import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/futures/cfm_futures_position.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a futures position for a specific product.
///
/// GET /v3/brokerage/cfm/positions/{product_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-futures-position
///
/// This function makes a GET request to the /cfm/positions/{product_id} endpoint
/// of the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the futures product.
/// [credential] - The user's API credentials.
/// [client] - An optional HTTP client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [CFMFuturesPosition] object.
Future<CFMFuturesPosition> getFuturesPosition({
  required String productId,
  required Credential credential,
  http.Client? client,
  bool isSandbox = false,
}) async {
  http.Response response = await getAuthorized(
    '/cfm/positions/$productId',
    client: client,
    credential: credential,
    isSandbox: isSandbox,
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var jsonPosition = jsonResponse['position'];
    return CFMFuturesPosition.fromCBJson(jsonPosition);
  } else {
    throw CoinbaseException(
        'Failed to get futures position', response.statusCode, response.body);
  }
}
