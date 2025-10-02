import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/products/products.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? apiKeyName = envVars['COINBASE_API_KEY_NAME'];
String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials =
    Credential(apiKeyName: apiKeyName!, privateKeyPEM: privateKeyPEM!);

void main() {
  group('Test Get Products Requests to Coinbase AT API', skip: skip, () {
    test('Authorized Get Products', () async {
      String requestPath = '/products';
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: false);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);

      expect(true, isTrue);
    });

    test('Authorized Get Products', () async {
      List<Product?> products =
          await getProducts(credential: credentials, isSandbox: false);
      print('Products: $products');
      expect(products.isNotEmpty, true);
    });

    test('Authorized Get Products with limit', () async {
      int limit = 100;
      List<Product?> products = await getProducts(
          limit: limit, credential: credentials, isSandbox: false);
      print('Products: $products');
      expect(products.isNotEmpty, true);
      expect(products.length, 100);
    });

    test('Get Product by Product ID', () async {
      String productId = 'MEDIA-USD';
      Product? product = await getProduct(
          productId: productId, credential: credentials, isSandbox: false);

      print('Product : $product');
      expect(product?.productId, productId);
    });

    test('Get Product by Product ID II', () async {
      List<Product?> originProducts =
          await getProducts(credential: credentials, isSandbox: false);

      String? productId = originProducts.first?.productId;
      Product? product = await getProduct(
          productId: productId, credential: credentials, isSandbox: false);

      print('Product : $product');
      expect(product?.productId, productId);
    });
  });
}
