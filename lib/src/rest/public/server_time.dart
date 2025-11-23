import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/server_time.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets the current time from the Coinbase Advanced API.
///
/// GET /api/v3/brokerage/time
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-server-time
///
/// Returns a [ServerTime] object.
Future<ServerTime?> getServerTime(
    {http.Client? client, bool isSandbox = false}) async {
  http.Response response =
      await get('/time', client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return ServerTime.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
        'Failed to get server time', response.statusCode, response.body);
  }
}
