import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/pro/models/ticker.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/pro/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets snapshot information about the last trade (tick), best bid/ask and 24h volume.
///
/// This function makes a GET request to the /products/{product_id}/ticker endpoint
/// of the Coinbase Pro API.
///
/// [tickerId] - The ID of the product to get the ticker for.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Ticker] object, or null if the request fails.
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
