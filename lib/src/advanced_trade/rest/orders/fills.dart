import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/fill.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

// Recursive for Paginated requests
Future<List<Fill>> getFills(
    {int? limit = 1000,
    String? orderId,
    String? productId,
    String? cursor,
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
      credential: credential,
      isSandbox: true);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonAccounts = jsonResponse['fills'];
    String? jsonCursor = jsonResponse['cursor'];

    for (var jsonObject in jsonAccounts) {
      orders.add(Fill.convertJson(jsonObject));
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
