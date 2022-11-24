import 'dart:convert';
import 'dart:io' show HttpHeaders;

import 'package:coinbase_cloud_exchange_dart_client/src/pro/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/pro/services/signature.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/shared/models/signature.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';
import 'package:http/http.dart' as http;

const String coinbaseApiProduction = 'api.exchange.coinbase.com';
const String coinbaseApiSandbox = 'api-public.sandbox.exchange.coinbase.com';

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

Future<http.Response> postAuthorized(String endpoint,
    {Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required Credential credential,
    bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;

  String params =
      (queryParameters != null) ? convertParamsToString(queryParameters)! : "";

  String bodyJson = (body != null) ? json.encode(body) : "";

  Signature? cbSignature =
      signature(credential.secret, "POST", endpoint, "$params$bodyJson");

  var url = Uri.https(coinbaseApi, endpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "CB-ACCESS-TIMESTAMP": cbSignature.timestamp,
    "CB-ACCESS-KEY": credential.accessKey,
    "CB-ACCESS-PASSPHRASE": credential.passphrase,
    "CB-ACCESS-SIGN": cbSignature.signature
  };

  if (body != null) {
    requestHeaders.addAll({HttpHeaders.contentTypeHeader: 'application/json'});
  }

  http.Response response =
      await http.post(url, headers: requestHeaders, body: bodyJson);

  return response;
}

Future<http.Response> deleteAuthorized(String endpoint,
    {Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required Credential credential,
    bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;

  String params =
      (queryParameters != null) ? convertParamsToString(queryParameters)! : "";

  String bodyJson = (body != null) ? json.encode(body) : "";

  Signature? cbSignature =
      signature(credential.secret, "DELETE", endpoint, "$params$bodyJson");

  var url = Uri.https(coinbaseApi, endpoint, queryParameters);
  Map<String, String> requestHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    "CB-ACCESS-TIMESTAMP": cbSignature.timestamp,
    "CB-ACCESS-KEY": credential.accessKey,
    "CB-ACCESS-PASSPHRASE": credential.passphrase,
    "CB-ACCESS-SIGN": cbSignature.signature
  };

  if (body != null) {
    requestHeaders.addAll({HttpHeaders.contentTypeHeader: 'application/json'});
  }

  http.Response response =
      await http.delete(url, headers: requestHeaders, body: bodyJson);

  return response;
}
