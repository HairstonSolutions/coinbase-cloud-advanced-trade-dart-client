import 'dart:convert';

import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/candle.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product_book.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of products.
///
/// GET /v3/brokerage/products
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/list-products
///
/// This function makes a GET request to the /products endpoint of the Coinbase
/// Advanced Trade API.
///
/// [offset] - An optional offset for pagination.
/// [productType] - An optional product type to filter by.
/// [contractExpiryType] - An optional contract expiry type to filter by.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Product] objects.
Future<List<Product>> getProductsAuthorized(
    {int? offset,
    String? productType,
    String? contractExpiryType,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Product> products = [];
  Map<String, String> queryParameters = {
    if (offset != null) 'offset': '$offset',
    if (productType != null) 'product_type': productType,
    if (contractExpiryType != null) 'contract_expiry_type': contractExpiryType,
  };

  http.Response response = await getAuthorized('/products',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonProducts = jsonResponse['products'];

    for (var jsonObject in jsonProducts) {
      products.add(Product.fromCBJson(jsonObject));
    }
  } else {
    throw Exception(
        'Failed to get products: ${response.statusCode} ${response.body}');
  }

  return products;
}

/// Gets a single product by product ID.
///
/// GET /v3/brokerage/products/{product_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-product
///
/// This function makes a GET request to the /products/{product_id} endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to be returned.
/// [getTradabilityStatus] - An optional flag to get the tradability status.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Product] object, or null if no product is found for the given
/// product ID.
Future<Product?> getProductAuthorized(
    {required String? productId,
    bool? getTradabilityStatus,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, String> queryParameters = {
    if (getTradabilityStatus != null)
      'get_tradability_status': '$getTradabilityStatus',
  };

  http.Response response = await getAuthorized('/products/$productId',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    return Product.fromCBJson(jsonResponse);
  } else {
    throw Exception(
        'Failed to get product: ${response.statusCode} ${response.body}');
  }
}

/// Gets product candles.
///
/// GET /v3/brokerage/products/{product_id}/candles
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-product-candles
///
/// This function makes a GET request to the /products/{product_id}/candles endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to be returned.
/// [start] - A start time for the candles.
/// [end] - A end time for the candles.
/// [granularity] - The granularity of the candles.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Candle] objects.
Future<List<Candle>> getProductCandlesAuthorized(
    {required String productId,
    required String start,
    required String end,
    required String granularity,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Candle> candles = [];
  Map<String, String> queryParameters = {
    'start': start,
    'end': end,
    'granularity': granularity,
  };

  http.Response response = await getAuthorized('/products/$productId/candles',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var jsonCandles = jsonResponse['candles'];

    for (var jsonObject in jsonCandles) {
      candles.add(Candle.fromJson(jsonObject));
    }
  } else {
    throw Exception(
        'Failed to get product candles: ${response.statusCode} ${response.body}');
  }
  return candles;
}

/// Gets a product book.
///
/// GET /v3/brokerage/product_book
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-product-book
///
/// This function makes a GET request to the /product_book endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to be returned.
/// [limit] - A limit for the number of products to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [ProductBook] object, or null if no product book is found for the
/// given product ID.
Future<ProductBook?> getProductBookAuthorized(
    {required String productId,
    int? limit,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, String> queryParameters = {
    'product_id': productId,
    if (limit != null) 'limit': '$limit',
  };

  http.Response response = await getAuthorized('/product_book',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    return ProductBook.fromJson(jsonResponse);
  } else {
    throw Exception(
        'Failed to get product book: ${response.statusCode} ${response.body}');
  }
}

/// Gets the best bid and ask for a list of products.
///
/// GET /v3/brokerage/best_bid_ask
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-best-bid-ask
///
/// This function makes a GET request to the /best_bid_ask endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productIds] - A list of product IDs to return the best bid and ask for.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [ProductBook] objects.
Future<List<ProductBook>> getBestBidAsk(
    {required List<String> productIds,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  List<ProductBook> productBooks = [];
  Map<String, dynamic> multiQueryParameters = {
    'product_ids': productIds,
  };

  http.Response response = await getAuthorized('/best_bid_ask',
      queryParameters: multiQueryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var jsonPricebooks = jsonResponse['pricebooks'];

    for (var jsonObject in jsonPricebooks) {
      productBooks.add(ProductBook.fromMap(jsonObject));
    }
  } else {
    throw Exception(
        'Failed to get best bid/ask: ${response.statusCode} ${response.body}');
  }
  return productBooks;
}
