import 'dart:io' show HttpHeaders;

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/signature.dart';
import 'package:http/http.dart' as http;

/// The production API host for Coinbase.
const String coinbaseApiProduction = 'api.coinbase.com';

/// The sandbox API host for Coinbase.
const String coinbaseApiSandbox = 'api-sandbox.coinbase.com';

/// Makes a GET request to the Coinbase Advanced Trade API.
///
/// [endpoint] - The API endpoint to make the request to.
/// [queryParameters] - Optional query parameters to include in the request.
/// [client] - Optional http.Client to use for the request.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [http.Response] object.
Future<http.Response> get(String endpoint,
    {Map<String, dynamic>? queryParameters,
    http.Client? client,
    bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;
  client ??= http.Client();

  String fullEndpoint = '/api/v3/brokerage$endpoint';

  var url = Uri.https(coinbaseApi, fullEndpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
  };

  return await client.get(url, headers: requestHeaders);
}

/// Makes an authorized GET request to the Coinbase Advanced Trade API.
///
/// This function generates a JWT, and then makes a GET request to the specified
/// endpoint with the JWT in the Authorization header.
///
/// [endpoint] - The API endpoint to make the request to.
/// [queryParameters] - Optional query parameters to include in the request.
/// [client] - Optional http.Client to use for the request.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [http.Response] object.
Future<http.Response> getAuthorized(String endpoint,
    {Map<String, dynamic>? queryParameters,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  return await _makeAuthorizedRequest(
      method: _HttpMethod.get,
      endpoint: endpoint,
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);
}

/// Makes an authorized POST request to the Coinbase Advanced Trade API.
///
/// This function generates a JWT, and then makes a POST request to the specified
/// endpoint with the JWT in the Authorization header.
///
/// [endpoint] - The API endpoint to make the request to.
/// [body] - The body of the request.
/// [client] - Optional http.Client to use for the request.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [http.Response] object.
Future<http.Response> postAuthorized(String endpoint,
    {String? body,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  return await _makeAuthorizedRequest(
      method: _HttpMethod.post,
      endpoint: endpoint,
      body: body,
      client: client,
      credential: credential,
      isSandbox: isSandbox);
}

/// Makes an authorized PUT request to the Coinbase Advanced Trade API.
///
/// This function generates a JWT, and then makes a PUT request to the specified
/// endpoint with the JWT in the Authorization header.
///
/// [endpoint] - The API endpoint to make the request to.
/// [body] - The body of the request.
/// [client] - Optional http.Client to use for the request.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [http.Response] object.
Future<http.Response> putAuthorized(String endpoint,
    {String? body,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  return await _makeAuthorizedRequest(
      method: _HttpMethod.put,
      endpoint: endpoint,
      body: body,
      client: client,
      credential: credential,
      isSandbox: isSandbox);
}

/// Makes an authorized DELETE request to the Coinbase Advanced Trade API.
///
/// This function generates a JWT, and then makes a DELETE request to the specified
/// endpoint with the JWT in the Authorization header.
///
/// [endpoint] - The API endpoint to make the request to.
/// [client] - Optional http.Client to use for the request.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [http.Response] object.
Future<http.Response> deleteAuthorized(String endpoint,
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  return await _makeAuthorizedRequest(
      method: _HttpMethod.delete,
      endpoint: endpoint,
      client: client,
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
    required Credential credential,
    bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;
  client ??= http.Client();

  String fullEndpoint = '/api/v3/brokerage$endpoint';

  String jwtToken = await generateCoinbaseJwt(
      credential.apiKeyName,
      credential.privateKeyPEM,
      "${method.name.toUpperCase()} $coinbaseApi$fullEndpoint");

  var url = Uri.https(coinbaseApi, fullEndpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "Authorization": "Bearer $jwtToken",
  };

  if (method == _HttpMethod.post || method == _HttpMethod.put) {
    requestHeaders[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  late final http.Response response;
  switch (method) {
    case _HttpMethod.get:
      response = await client.get(url, headers: requestHeaders);
      break;
    case _HttpMethod.post:
      response = await client.post(url, headers: requestHeaders, body: body);
      break;
    case _HttpMethod.put:
      response = await client.put(url, headers: requestHeaders, body: body);
      break;
    case _HttpMethod.delete:
      response = await client.delete(url, headers: requestHeaders);
      break;
  }
  return response;
}
