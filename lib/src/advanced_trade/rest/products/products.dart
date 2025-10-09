import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
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
Future<List<Product>> getProducts(
    {int? offset,
    String? productType,
    String? contractExpiryType,
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
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
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
Future<Product?> getProduct(
    {required String? productId,
    bool? getTradabilityStatus,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, String> queryParameters = {
    if (getTradabilityStatus != null)
      'get_tradability_status': '$getTradabilityStatus',
  };

  http.Response response = await getAuthorized('/products/$productId',
      queryParameters: queryParameters,
      credential: credential,
      isSandbox: isSandbox);

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
