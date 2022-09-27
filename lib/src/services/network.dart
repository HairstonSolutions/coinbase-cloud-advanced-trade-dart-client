import 'dart:io' show HttpHeaders;

import 'package:http/http.dart' as http;

const String coinbaseApiProduction = 'api.exchange.coinbase.com';
const String coinbaseApiSandbox = 'api-public.sandbox.exchange.coinbase.com';

Future<http.Response> get(String endpoint, {bool isSandbox = false}) async {
  String coinbaseApi = isSandbox ? coinbaseApiSandbox : coinbaseApiProduction;

  var url = Uri.https(coinbaseApi, endpoint);
  Map<String, String> myMap = {
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.get(url, headers: myMap);

  return response;
}
