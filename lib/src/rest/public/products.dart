import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/product_candle.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
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
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
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
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return products;
}

/// Gets product candles
///
/// GET /api/v3/brokerage/market/products/{product_id}/candles
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product-candles
///
/// This function makes a GET request to the /market/products/{product_id}/candles endpoint of
/// the Coinbase Advanced Trade API.
///
/// [productId] - The ID of the product to get candles for.
/// [start] - The start time for the candles.
/// [end] - The end time for the candles.
/// [granularity] - The granularity of the candles.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [ProductCandle] objects.
Future<List<ProductCandle>> getProductCandles(
    {required String productId,
    required String start,
    required String end,
    required String granularity,
    http.Client? client,
    bool isSandbox = false}) async {
  List<ProductCandle> productCandles = [];
  Map<String, String> queryParameters = {
    'start': start,
    'end': end,
    'granularity': granularity,
  };

  http.Response response = await get('/market/products/$productId/candles',
      queryParameters: queryParameters, client: client, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonProductCandles = jsonResponse['candles'];

    for (var jsonObject in jsonProductCandles) {
      productCandles.add(ProductCandle.fromCBJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return productCandles;
}
