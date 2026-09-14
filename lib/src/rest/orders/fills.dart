import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/coinbase_http_options.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/fill.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/page.dart';
import 'package:http/http.dart' as http;

/// Gets a single page of fills for the current user.
///
/// GET /v3/brokerage/orders/historical/fills
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-fills
///
/// This function makes a GET request to the /orders/historical/fills endpoint
/// of the Coinbase Advanced Trade API. It supports pagination using a cursor.
///
/// [limit] - A limit on the number of fills to be returned.
/// [orderId] - An optional order ID to filter fills by.
/// [productId] - An optional product ID to filter fills by.
/// [cursor] - A cursor for pagination.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Page] of [Fill] objects.
Future<Page<Fill>> getFillsPage(
    {int? limit = 1000,
    @Deprecated('Use orderIds instead') String? orderId,
    List<String>? orderIds,
    @Deprecated('Use productIds instead') String? productId,
    List<String>? productIds,
    String? startSequenceTimestamp,
    String? endSequenceTimestamp,
    String? cursor,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Fill> fills = [];
  Map<String, dynamic> queryParameters = {'limit': '$limit'};

  List<String> combinedOrderIds = [
    if (orderId != null) orderId,
    if (orderIds != null) ...orderIds,
  ];
  if (combinedOrderIds.isNotEmpty) {
    queryParameters['order_ids'] = combinedOrderIds;
  }

  List<String> combinedProductIds = [
    if (productId != null) productId,
    if (productIds != null) ...productIds,
  ];
  if (combinedProductIds.isNotEmpty) {
    queryParameters['product_ids'] = combinedProductIds;
  }

  if (startSequenceTimestamp != null) {
    queryParameters['start_sequence_timestamp'] = startSequenceTimestamp;
  }
  if (endSequenceTimestamp != null) {
    queryParameters['end_sequence_timestamp'] = endSequenceTimestamp;
  }
  if (cursor != null) {
    queryParameters['cursor'] = cursor;
  }

  http.Response response = await getAuthorized('/orders/historical/fills',
      queryParameters: queryParameters,
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonFills = jsonResponse['fills'];
    String? jsonCursor = jsonResponse['cursor'];
    bool hasNext = jsonResponse['has_next'] ?? false;

    for (var jsonObject in jsonFills) {
      fills.add(Fill.fromCBJson(jsonObject));
    }

    return Page<Fill>(
      items: fills,
      nextCursor: jsonCursor,
      hasNext: hasNext,
    );
  } else {
    throw CoinbaseException(
        'Failed to get fills page', response.statusCode, response.body);
  }
}

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
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Fill] objects.
Future<List<Fill>> getFills(
    {int? limit = 1000,
    @Deprecated('Use orderIds instead') String? orderId,
    List<String>? orderIds,
    @Deprecated('Use productIds instead') String? productId,
    List<String>? productIds,
    String? startSequenceTimestamp,
    String? endSequenceTimestamp,
    String? cursor,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Fill> fills = [];
  String? currentCursor = cursor;

  while (true) {
    Page<Fill> page = await getFillsPage(
        limit: limit,
        orderId: orderId,
        orderIds: orderIds,
        productId: productId,
        productIds: productIds,
        startSequenceTimestamp: startSequenceTimestamp,
        endSequenceTimestamp: endSequenceTimestamp,
        cursor: currentCursor,
        client: client,
        options: options,
        credential: credential,
        isSandbox: isSandbox);

    fills.addAll(page.items);

    if (page.nextCursor != null && page.nextCursor != '') {
      currentCursor = page.nextCursor;
    } else {
      break;
    }
  }

  return fills;
}
