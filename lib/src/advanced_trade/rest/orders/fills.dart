import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/fill.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of fills for the current user.
///
/// GET /v3/brokerage/orders/historical/fills
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-fills
///
/// This function makes a GET request to the /orders/historical/fills endpoint
/// of the Coinbase Advanced Trade API. It supports pagination using a cursor.
/// Paginated requests use recursion.
///
/// [limit] - A limit on the number of fills to be returned.
/// [orderId] - An optional order ID to filter fills by.
/// [productId] - An optional product ID to filter fills by.
/// [cursor] - A cursor for pagination.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Fill] objects.
Future<List<Fill>> getFills(
    {int? limit = 1000,
    String? orderId,
    String? productId,
    String? cursor,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Fill> orders = [];
  Map<String, dynamic>? queryParameters = {'limit': '$limit'};
  (orderId != null) ? queryParameters.addAll({'order_id': orderId}) : null;
  (productId != null)
      ? queryParameters.addAll({'product_id': productId})
      : null;
  (cursor != null) ? queryParameters.addAll({'cursor': cursor}) : null;

  http.Response response = await getAuthorized('/orders/historical/fills',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonAccounts = jsonResponse['fills'];
    String? jsonCursor = jsonResponse['cursor'];

    for (var jsonObject in jsonAccounts) {
      orders.add(Fill.fromCBJson(jsonObject));
    }
    // Recursive Break
    if (jsonCursor != null && jsonCursor != '') {
      // Recursive Call
      List<Fill> paginatedAccounts = await getFills(
          limit: limit,
          cursor: jsonCursor,
          credential: credential,
          isSandbox: isSandbox);
      orders.addAll(paginatedAccounts);
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return orders;
}
