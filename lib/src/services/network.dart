import 'dart:io' show HttpHeaders;

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/signature.dart';
import 'package:http/http.dart' as http;

const String coinbaseApiProduction = 'api.coinbase.com';
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
      method: _HttpMethod.GET,
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
      method: _HttpMethod.POST,
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
      method: _HttpMethod.PUT,
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
      method: _HttpMethod.DELETE,
      endpoint: endpoint,
      client: client,
      credential: credential,
      isSandbox: isSandbox);
}

enum _HttpMethod { GET, POST, PUT, DELETE }

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

  String jwtToken = await generateCoinbaseJwt(credential.apiKeyName,
      credential.privateKeyPEM, "${method.name} $coinbaseApi$fullEndpoint");

  var url = Uri.https(coinbaseApi, fullEndpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "Authorization": "Bearer $jwtToken",
  };

  if (method == _HttpMethod.POST || method == _HttpMethod.PUT) {
    requestHeaders[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  final request = http.Request(method.name, url);
  request.headers.addAll(requestHeaders);
  if (body != null) {
    request.body = body;
  }

  final streamedResponse = await client.send(request);
  return http.Response.fromStream(streamedResponse);
}
