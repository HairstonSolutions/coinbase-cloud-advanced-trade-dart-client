import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/candle.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product_book.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/ticker.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a single product by product ID.
///
/// GET /api/v3/brokerage/market/products/{product_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product
///
/// This function makes a GET request to the /products/{product_id} endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to be returned.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Product] object, or null if no product is found for the given
/// product ID.
Future<Product?> getProduct(
    {required String productId,
    http.Client? client,
    bool isSandbox = false}) async {
  http.Response response = await get('/market/products/$productId',
      client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    return Product.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
        'Failed to get product', response.statusCode, response.body);
  }
}

/// Gets public product candles.
///
/// GET /api/v3/brokerage/market/products/{product_id}/candles
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product-candles
///
/// This function makes a GET request to the /market/products/{product_id}/candles endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to be returned.
/// [start] - A start time for the candles.
/// [end] - A end time for the candles.
/// [granularity] - The granularity of the candles.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Candle] objects.
Future<List<Candle>> getProductCandles(
    {required String productId,
    required String start,
    required String end,
    required String granularity,
    http.Client? client,
    bool isSandbox = false}) async {
  List<Candle> candles = [];
  Map<String, String> queryParameters = {
    'start': start,
    'end': end,
    'granularity': granularity,
  };

  http.Response response = await get('/market/products/$productId/candles',
      queryParameters: queryParameters, client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var jsonCandles = jsonResponse['candles'];

    for (var jsonObject in jsonCandles) {
      candles.add(Candle.fromJson(jsonObject));
    }
  } else {
    throw CoinbaseException(
        'Failed to get product candles', response.statusCode, response.body);
  }
  return candles;
}

/// Gets a list of products.
///
/// GET /api/v3/brokerage/market/products
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/list-public-products
///
/// This function makes a GET request to the /products endpoint of the Coinbase
/// Advanced Trade API.
///
/// [limit] - A limit for the number of products to be returned.
/// [offset] - An optional offset for pagination.
/// [productType] - An optional product type to filter by.
/// [productIds] - An optional list of product IDs to filter by.
/// [contractExpiryType] - An optional contract expiry type to filter by.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Product] objects.
Future<List<Product>> getProducts(
    {int? limit,
    int? offset,
    String? productType,
    List<String>? productIds,
    String? contractExpiryType,
    http.Client? client,
    bool isSandbox = false}) async {
  List<Product> products = [];
  Map<String, String> queryParameters = {
    if (limit != null) 'limit': '$limit',
    if (offset != null) 'offset': '$offset',
    if (productType != null) 'product_type': productType,
    if (productIds != null) 'product_ids': productIds.join(','),
    if (contractExpiryType != null) 'contract_expiry_type': contractExpiryType,
  };

  http.Response response = await get('/market/products',
      queryParameters: queryParameters, client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonProducts = jsonResponse['products'];

    for (var jsonObject in jsonProducts) {
      products.add(Product.fromCBJson(jsonObject));
    }
  } else {
    throw CoinbaseException(
        'Failed to get products', response.statusCode, response.body);
  }

  return products;
}

/// Gets a public product book.
///
/// GET /api/v3/brokerage/market/product_book
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product-book
///
/// This function makes a GET request to the /market/product_book endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to be returned.
/// [limit] - A limit for the number of products to be returned.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [ProductBook] object, or null if no product book is found for the
/// given product ID.
Future<ProductBook?> getProductBook(
    {required String productId,
    int? limit,
    http.Client? client,
    bool isSandbox = false}) async {
  Map<String, String> queryParameters = {
    'product_id': productId,
    if (limit != null) 'limit': '$limit',
  };

  http.Response response = await get('/market/product_book',
      queryParameters: queryParameters, client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    return ProductBook.fromJson(jsonResponse);
  } else {
    throw CoinbaseException(
        'Failed to get product book', response.statusCode, response.body);
  }
}

/// Gets public market trades for a given product ID.
///
/// GET /api/v3/brokerage/market/products/{product_id}/ticker
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-market-trades
///
/// This function makes a GET request to the /market/products/{product_id}/ticker endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to be returned.
/// [limit] - A limit for the number of trades to be returned.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Ticker] object.
Future<Ticker?> getMarketTrades(
    {required String productId,
    int? limit,
    http.Client? client,
    bool isSandbox = false}) async {
  Map<String, String> queryParameters = {
    if (limit != null) 'limit': '$limit',
  };

  http.Response response = await get('/market/products/$productId/ticker',
      queryParameters: queryParameters, client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    return Ticker.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
        'Failed to get market trades', response.statusCode, response.body);
  }
}
