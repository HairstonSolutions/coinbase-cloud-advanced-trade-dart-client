import 'dart:io' show HttpHeaders;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/signature.dart';
import 'package:http/http.dart' as http;

const String coinbaseApiProduction = 'api.coinbase.com';
const String coinbaseApiSandbox = 'api-sandbox.coinbase.com';

/// Makes an authorized GET request to the Coinbase Advanced Trade API.
///
/// This function generates a JWT, and then makes a GET request to the specified
/// endpoint with the JWT in the Authorization header.
///
/// [endpoint] - The API endpoint to make the request to.
/// [queryParameters] - Optional query parameters to include in the request.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [http.Response] object.
Future<http.Response> getAuthorized(String endpoint,
    {Map<String, dynamic>? queryParameters,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;
  client ??= http.Client();

  String fullEndpoint = '/api/v3/brokerage$endpoint';

  String jwtToken = await generateCoinbaseJwt(credential.apiKeyName,
      credential.privateKeyPEM, "GET $coinbaseApi$fullEndpoint");

  var url = Uri.https(coinbaseApi, fullEndpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "Authorization": "Bearer $jwtToken",
  };

  return await client.get(url, headers: requestHeaders);
}
