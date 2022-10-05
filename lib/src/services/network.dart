import 'dart:io' show HttpHeaders;

import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/signature.dart';
import 'package:http/http.dart' as http;

import '../models/signature.dart';

const String coinbaseApiProduction = 'api.exchange.coinbase.com';
const String coinbaseApiSandbox = 'api-public.sandbox.exchange.coinbase.com';

String? convertParamsToString(Map<String, dynamic> queryParameters) {
  late String conversion;
  conversion = "";

  if (queryParameters.isNotEmpty) {
    conversion = "?";
    int count = 0;

    for (var entry in queryParameters.entries) {
      if (count > 0) {
        conversion = "$conversion&";
      }
      conversion = "$conversion${entry.key}=${entry.value}";
      count++;
    }
  }

  return conversion;
}

Future<http.Response> get(String endpoint,
    {Map<String, dynamic>? queryParameters, bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;

  var url = Uri.https(coinbaseApi, endpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.get(url, headers: requestHeaders);

  return response;
}

Future<http.Response> getAuthorized(String endpoint,
    {Map<String, dynamic>? queryParameters,
    required Credential credential,
    bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;

  String params =
      (queryParameters == null) ? "" : convertParamsToString(queryParameters)!;

  Signature? cbSignature =
      signature(credential.secret, "GET", endpoint, params);

  var url = Uri.https(coinbaseApi, endpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "CB-ACCESS-TIMESTAMP": cbSignature.timestamp,
    "CB-ACCESS-KEY": credential.accessKey,
    "CB-ACCESS-PASSPHRASE": credential.passphrase,
    "CB-ACCESS-SIGN": cbSignature.signature
  };

  http.Response response = await http.get(url, headers: requestHeaders);

  return response;
}
