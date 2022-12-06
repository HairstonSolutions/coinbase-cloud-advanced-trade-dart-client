import 'dart:io' show HttpHeaders;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/signature.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/shared/models/signature.dart';
import 'package:http/http.dart' as http;

const String coinbaseApiProduction = 'coinbase.com';
const String coinbaseApiSandbox = 'coinbase.com';
// const String coinbaseApiSandbox = 'sandbox.coinbase.com/api/v3/brokerage';

Future<http.Response> getAuthorized(String endpoint,
    {Map<String, dynamic>? queryParameters,
    required Credential credential,
    bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;

  String fullEndpoint = '/api/v3/brokerage$endpoint';

  Signature? cbSignature = signature(credential.apiSecret, "GET", fullEndpoint);

  var url = Uri.https(coinbaseApi, fullEndpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "CB-ACCESS-TIMESTAMP": cbSignature.timestamp,
    "CB-ACCESS-KEY": credential.apiKey,
    "CB-ACCESS-SIGN": cbSignature.signature
  };

  http.Response response = await http.get(url, headers: requestHeaders);

  return response;
}
