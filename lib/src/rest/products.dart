import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/best_bid_ask.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/candles.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/public_product_book.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets the best bid and ask for a list of products.
///
/// GET /api/v3/brokerage/best_bid_ask
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-best-bid-ask
///
/// [productIds] - A list of product IDs to get the best bid and ask for.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [BestBidAsk] object.
Future<BestBidAsk?> getBestBidAsk(
    {List<String>? productIds,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {};
  if (productIds != null) {
    queryParameters.addAll({'product_ids': productIds});
  }

  http.Response response = await getAuthorized('/best_bid_ask',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return BestBidAsk.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets the product book for a given product.
///
/// GET /api/v3/brokerage/product_book
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-product-book
///
/// [productId] - The product ID to get the book for.
/// [limit] - The number of entries to return.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PublicProductBook] object.
Future<PublicProductBook?> getProductBook(
    {required String productId,
    int? limit,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {'product_id': productId};
  (limit != null) ? queryParameters.addAll({'limit': '$limit'}) : null;

  http.Response response = await getAuthorized('/product_book',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PublicProductBook.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets product candles.
///
/// GET /api/v3/brokerage/products/{product_id}/candles
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-product-candles
///
/// [productId] - The product ID to get candles for.
/// [start] - The start time for the candles.
/// [end] - The end time for the candles.
/// [granularity] - The granularity of the candles.
/// [limit] - The number of candles to return.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Candles] object.
Future<Candles?> getProductCandles(
    {required String productId,
    required String start,
    required String end,
    required String granularity,
    int? limit,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {
    'start': start,
    'end': end,
    'granularity': granularity,
  };
  (limit != null) ? queryParameters.addAll({'limit': '$limit'}) : null;

  http.Response response = await getAuthorized(
      '/products/$productId/candles',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return Candles.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}
