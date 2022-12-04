import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/product.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> getProducts(
    {int? limit = 250,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Product> products = [];
  Map<String, dynamic>? queryParameters = {'limit': '$limit'};

  http.Response response = await getAuthorized('/products',
      queryParameters: queryParameters,
      credential: credential,
      isSandbox: true);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonProducts = jsonResponse['products'];

    for (var jsonObject in jsonProducts) {
      products.add(Product.convertJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return products;
}

Future<Product?> getProduct(
    {required String? productId,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/products/$productId',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    return Product.convertJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}
