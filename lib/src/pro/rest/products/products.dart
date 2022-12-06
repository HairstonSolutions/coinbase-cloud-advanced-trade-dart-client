import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/pro/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/pro/services/network.dart';
import 'package:http/http.dart' as http;

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
