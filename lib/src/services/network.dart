import 'dart:async';
import 'dart:io' show HttpDate, HttpHeaders;

import 'package:coinbase_cloud_advanced_trade_client/src/models/coinbase_http_options.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/signature.dart';
import 'package:http/http.dart' as http;

/// The production API host for Coinbase.
const String coinbaseApiProduction = 'api.coinbase.com';

/// The sandbox API host for Coinbase.
const String coinbaseApiSandbox = 'api-sandbox.coinbase.com';

Duration? _parseRetryAfter(String? retryAfterHeader) {
  if (retryAfterHeader == null) return null;
  // Try parsing as integer seconds
  int? seconds = int.tryParse(retryAfterHeader);
  if (seconds != null) {
    return Duration(seconds: seconds);
  }
  // Try parsing as HTTP date
  try {
    DateTime date = HttpDate.parse(retryAfterHeader);
    return date.difference(DateTime.now().toUtc());
  } catch (_) {
    return null;
  }
}

Future<http.Response> _executeWithTimeout(
    Future<http.Response> Function() requestFuture, Duration? timeout) async {
  try {
    if (timeout != null) {
      return await requestFuture().timeout(timeout);
    }
    return await requestFuture();
  } on TimeoutException catch (_) {
    throw CoinbaseTimeoutException('Request timed out after $timeout');
  }
}

void _checkResponseForErrors(http.Response response) {
  if (response.statusCode == 429) {
    throw CoinbaseException(
      'Rate limit exceeded',
      response.statusCode,
      response.body,
      retryAfter: _parseRetryAfter(response.headers['retry-after']),
    );
  }
}

/// Makes a GET request to the Coinbase Advanced Trade API.
///
/// [endpoint] - The API endpoint to make the request to.
/// [queryParameters] - Optional query parameters to include in the request.
/// [client] - Optional http.Client to use for the request.
/// [options] - Optional configurations like baseUrl, timeout, and client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [http.Response] object.
Future<http.Response> get(String endpoint,
    {Map<String, dynamic>? queryParameters,
    http.Client? client,
    CoinbaseHttpOptions? options,
    bool isSandbox = false}) async {
  String defaultHost = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;
  http.Client activeClient = options?.client ?? client ?? http.Client();

  String fullEndpoint = '/api/v3/brokerage$endpoint';

  Uri url;
  if (options?.baseUrl != null) {
    url = options!.baseUrl!.replace(
      path: options.baseUrl!.path + fullEndpoint,
      queryParameters:
          queryParameters?.isEmpty == true ? null : queryParameters,
    );
  } else {
    url = Uri.https(defaultHost, fullEndpoint, queryParameters);
  }

  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
  };

  var response = await _executeWithTimeout(
      () => activeClient.get(url, headers: requestHeaders), options?.timeout);

  _checkResponseForErrors(response);
  return response;
}

/// Makes an authorized GET request to the Coinbase Advanced Trade API.
Future<http.Response> getAuthorized(String endpoint,
    {Map<String, dynamic>? queryParameters,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  return await _makeAuthorizedRequest(
      method: _HttpMethod.get,
      endpoint: endpoint,
      queryParameters: queryParameters,
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);
}

/// Makes an authorized POST request to the Coinbase Advanced Trade API.
Future<http.Response> postAuthorized(String endpoint,
    {String? body,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  return await _makeAuthorizedRequest(
      method: _HttpMethod.post,
      endpoint: endpoint,
      body: body,
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);
}

/// Makes an authorized PUT request to the Coinbase Advanced Trade API.
Future<http.Response> putAuthorized(String endpoint,
    {String? body,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  return await _makeAuthorizedRequest(
      method: _HttpMethod.put,
      endpoint: endpoint,
      body: body,
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);
}

/// Makes an authorized DELETE request to the Coinbase Advanced Trade API.
Future<http.Response> deleteAuthorized(String endpoint,
    {http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  return await _makeAuthorizedRequest(
      method: _HttpMethod.delete,
      endpoint: endpoint,
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);
}

enum _HttpMethod { get, post, put, delete }

Future<http.Response> _makeAuthorizedRequest(
    {required _HttpMethod method,
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    String? body,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  String defaultHost = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;
  http.Client activeClient = options?.client ?? client ?? http.Client();

  String fullEndpoint = '/api/v3/brokerage$endpoint';

  Uri url;
  String hostForJwt;
  String pathForJwt;

  if (options?.baseUrl != null) {
    url = options!.baseUrl!.replace(
      path: options.baseUrl!.path + fullEndpoint,
      queryParameters:
          queryParameters?.isEmpty == true ? null : queryParameters,
    );
    // JWT requires host and full path
    hostForJwt = options.baseUrl!.host;
    if (options.baseUrl!.hasPort) {
      // If the custom base URL has a port, include it in the host for JWT as it matches the authority
      // However, according to Coinbase docs it's usually just the hostname + path. Let's just use authority for safety, or host?
      // Wait, the existing code did "$coinbaseApi$fullEndpoint", where coinbaseApi is just the host. So it's host + path.
      // Let's use host + port if it's not standard
      if (options.baseUrl!.port != 80 && options.baseUrl!.port != 443) {
        hostForJwt = '${options.baseUrl!.host}:${options.baseUrl!.port}';
      }
    }
    pathForJwt = url.path;
  } else {
    url = Uri.https(defaultHost, fullEndpoint, queryParameters);
    hostForJwt = defaultHost;
    pathForJwt = fullEndpoint;
  }

  String jwtToken = await generateCoinbaseJwt(
      credential.apiKeyName,
      credential.privateKeyPEM,
      "${method.name.toUpperCase()} $hostForJwt$pathForJwt");

  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "Authorization": "Bearer $jwtToken",
  };

  if (method == _HttpMethod.post || method == _HttpMethod.put) {
    requestHeaders[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  var response = await _executeWithTimeout(() async {
    switch (method) {
      case _HttpMethod.get:
        return await activeClient.get(url, headers: requestHeaders);
      case _HttpMethod.post:
        return await activeClient.post(url,
            headers: requestHeaders, body: body);
      case _HttpMethod.put:
        return await activeClient.put(url, headers: requestHeaders, body: body);
      case _HttpMethod.delete:
        return await activeClient.delete(url, headers: requestHeaders);
    }
  }, options?.timeout);

  _checkResponseForErrors(response);
  return response;
}
