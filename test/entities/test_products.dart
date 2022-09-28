import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/entities/products.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/product.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? checkEnvSandbox = envVars['COINBASE_SANDBOX'];
bool isSbx = checkEnvSandbox == 'true' ? true : false;

void main() {
  group('Test Requests to Coinbase API Endpoints', () {
    setUp(() {});

    test('Get Products from Production', () async {
      List<Product> products = await getProducts();
      print('Products: $products');

      expect(products.isNotEmpty, isTrue);
    });
  });
}
