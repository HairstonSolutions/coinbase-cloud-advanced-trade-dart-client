import 'dart:convert';

import 'package:coinbase_pro_sdk/src/models/product.dart';
import 'package:coinbase_pro_sdk/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of available products.
///
/// This function makes a GET request to the /products endpoint of the Coinbase
/// Pro API.
///
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Product] objects.
Future<List<Product>> getProducts({bool isSandbox = false}) async {
  List<Product> products = [];

  http.Response response = await get('/products', isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);

    for (var jsonObject in jsonResponse) {
      products.add(Product.convertJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed.');
  }

  return products;
}

/// Gets a single product by product ID.
///
/// This function makes a GET request to the /products/{product_id} endpoint of
/// the Coinbase Pro API.
///
/// [tickerId] - The ID of the product to be returned.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Product] object, or null if no product is found for the given
/// product ID.
Future<Product?> getProduct(String tickerId, {bool isSandbox = false}) async {
  late Product product;

  http.Response response =
      await get('/products/$tickerId', isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    product = Product.convertJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed.');
  }

  return product;
}
