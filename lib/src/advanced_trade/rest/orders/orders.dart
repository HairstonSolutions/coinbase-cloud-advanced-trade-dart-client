import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of historical orders for the current user.
///
/// GET /v3/brokerage/orders/historical/batch
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-orders
///
/// This function makes a GET request to the /orders/historical/batch endpoint
/// of the Coinbase Advanced Trade API. It supports pagination using a cursor.
///
/// [limit] - A limit on the number of orders to be returned.
/// [cursor] - A cursor for pagination.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Order] objects.
Future<List<Order>> getOrders(
    {int? limit = 1000,
    String? cursor,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Order> orders = [];
  Map<String, dynamic>? queryParameters = {'limit': '$limit'};
  (cursor != null) ? queryParameters.addAll({'cursor': cursor}) : null;

  http.Response response = await getAuthorized('/orders/historical/batch',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonAccounts = jsonResponse['orders'];
    String? jsonCursor = jsonResponse['cursor'];

    for (var jsonObject in jsonAccounts) {
      orders.add(Order.fromCBJson(jsonObject));
    }
    // Recursive Break
    if (jsonCursor != null && jsonCursor != '') {
      // Recursive Call
      List<Order> paginatedAccounts = await getOrders(
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

/// Gets a single historical order for the current user by order ID.
///
/// GET /v3/brokerage/orders/historical/{order_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/get-order
///
/// This function makes a GET request to the /orders/historical/{order_id}
/// endpoint of the Coinbase Advanced Trade API.
///
/// [orderId] - The ID of the order to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Order] object, or null if no order is found for the given
/// order ID.
Future<Order?> getOrder(
    {required String orderId,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Order? order;

  http.Response response = await getAuthorized('/orders/historical/$orderId',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonOrder = jsonResponse['order'];
    order = Order.fromCBJson(jsonOrder);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return order;
}
