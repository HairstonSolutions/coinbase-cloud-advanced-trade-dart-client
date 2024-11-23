import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

Future<List<Trade>> getTrades(
    {required String? productId,
    int? limit = 10,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Trade> trades = [];
  Map<String, dynamic>? queryParameters = {'limit': '$limit'};

  http.Response response = await getAuthorized('/products/$productId/ticker',
      queryParameters: queryParameters,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonTrades = jsonResponse['trades'];

    for (var jsonObject in jsonTrades) {
      trades.add(Trade.fromCBJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return trades;
}
