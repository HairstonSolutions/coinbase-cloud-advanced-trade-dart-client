import 'dart:io' show HttpHeaders;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/signature.dart';
import 'package:http/http.dart' as http;

const String coinbaseApiProduction = 'api.coinbase.com';
const String coinbaseApiSandbox = 'api-sandbox.coinbase.com';

Future<http.Response> getAuthorized(String endpoint,
    {Map<String, dynamic>? queryParameters,
    required Credential credential,
    bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;

  String fullEndpoint = '/api/v3/brokerage$endpoint';

  String jwtToken = await generateCoinbaseJwt(credential.apiKeyName,
      credential.privateKeyPEM, "GET $coinbaseApi$fullEndpoint");

  var url = Uri.https(coinbaseApi, fullEndpoint);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "Authorization": "Bearer $jwtToken",
  };

  return await http.get(url, headers: requestHeaders);
}
