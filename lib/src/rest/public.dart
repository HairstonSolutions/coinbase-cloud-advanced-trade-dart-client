import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/candles.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/public_product_book.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/public_products.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/server_time.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/ticker.dart';
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
      await getUnauthorized('/time', client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return ServerTime.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets the public product book for a given product.
///
/// GET /api/v3/brokerage/market/product_book
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product-book
///
/// [productId] - The product ID to get the book for.
/// [limit] - The number of entries to return.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PublicProductBook] object.
Future<PublicProductBook?> getProductBook(
    {required String productId,
    int? limit,
    http.Client? client,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {'product_id': productId};
  (limit != null) ? queryParameters.addAll({'limit': '$limit'}) : null;

  http.Response response = await getUnauthorized('/market/product_book',
      queryParameters: queryParameters, client: client, isSandbox: isSandbox);

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

/// Gets the public products.
///
/// GET /api/v3/brokerage/market/products
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/list-public-products
///
/// [limit] - The number of products to return.
/// [offset] - The number of products to skip.
/// [productType] - The type of products to return.
/// [productIds] - The list of product IDs to return.
///
/// Returns a [PublicProducts] object.
Future<PublicProducts?> listProducts(
    {int? limit,
    int? offset,
    String? productType,
    List<String>? productIds,
    http.Client? client,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {};
  (limit != null) ? queryParameters.addAll({'limit': '$limit'}) : null;
  (offset != null) ? queryParameters.addAll({'offset': '$offset'}) : null;
  (productType != null)
      ? queryParameters.addAll({'product_type': productType})
      : null;
  (productIds != null)
      ? queryParameters.addAll({'product_ids': productIds})
      : null;

  http.Response response = await getUnauthorized('/market/products',
      queryParameters: queryParameters, client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PublicProducts.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets a public product.
///
/// GET /api/v3/brokerage/market/products/{product_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product
///
/// [productId] - The product ID to get.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Product] object.
Future<Product?> getProduct(
    {required String productId,
    http.Client? client,
    bool isSandbox = false}) async {
  http.Response response = await getUnauthorized('/market/products/$productId',
      client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return Product.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets public product candles.
///
/// GET /api/v3/brokerage/market/products/{product_id}/candles
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product-candles
///
/// [productId] - The product ID to get candles for.
/// [start] - The start time for the candles.
/// [end] - The end time for the candles.
/// [granularity] - The granularity of the candles.
/// [limit] - The number of candles to return.
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
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {
    'start': start,
    'end': end,
    'granularity': granularity,
  };
  (limit != null) ? queryParameters.addAll({'limit': '$limit'}) : null;

  http.Response response = await getUnauthorized(
      '/market/products/$productId/candles',
      queryParameters: queryParameters,
      client: client,
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

/// Gets public market trades.
///
/// GET /api/v3/brokerage/market/products/{product_id}/ticker
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-market-trades
///
/// [productId] - The product ID to get trades for.
/// [limit] - The number of trades to return.
/// [start] - The start time for the trades.
/// [end] - The end time for the trades.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Ticker] object.
Future<Ticker?> getMarketTrades(
    {required String productId,
    required int limit,
    String? start,
    String? end,
    http.Client? client,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {'limit': '$limit'};
  (start != null) ? queryParameters.addAll({'start': start}) : null;
  (end != null) ? queryParameters.addAll({'end': end}) : null;

  http.Response response = await getUnauthorized(
      '/market/products/$productId/ticker',
      queryParameters: queryParameters,
      client: client,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return Ticker.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}
