import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/pro/models/ticker.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/pro/services/network.dart';
import 'package:http/http.dart' as http;

Future<Ticker?> getTicker(String tickerId, {bool isSandbox = false}) async {
  Ticker? ticker;

  http.Response response =
      await get('/products/$tickerId/ticker', isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    ticker = Ticker.convertJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed.');
  }
  return ticker;
}
