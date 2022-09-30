import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/models/ticker.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
import 'package:http/http.dart' as http;

Future<Ticker> getTicker(String tickerId, {bool isSandbox = false}) async {
  late Ticker ticker;

  http.Response response =
      await get('/products/$tickerId/ticker', isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    ticker = convertTickerJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed.');
  }
  return ticker;
}

Ticker convertTickerJson(var jsonObject) {
  double? ask = double.parse(jsonObject['ask']);
  double? bid = double.parse(jsonObject['bid']);
  double? volume = double.parse(jsonObject['volume']);
  int? tradeId = jsonObject['trade_id'];
  double? price = double.parse(jsonObject['price']);
  double? size = double.parse(jsonObject['size']);
  String? time = jsonObject['time'];

  return Ticker(ask, bid, volume, tradeId, price, size, time);
}
