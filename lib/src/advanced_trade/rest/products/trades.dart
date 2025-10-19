import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of recent market trades for a single product.
///
/// GET /v3/brokerage/products/{product_id}/ticker - Get Market Trades
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-market-trades
///
/// This function makes a GET request to the /products/{product_id}/ticker
/// endpoint of the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to get trades for.
/// [limit] - A limit on the number of trades to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Trade] objects.
Future<List<Trade>> getTrades(
    {required String? productId,
    int? limit = 10,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Trade> trades = [];
  Map<String, dynamic>? queryParameters = {'limit': '$limit'};

  http.Response response = await getAuthorized('/products/$productId/ticker',
      queryParameters: queryParameters,
      client: client,
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
