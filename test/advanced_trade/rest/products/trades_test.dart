import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/product.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/trade.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/rest/products/products.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/rest/products/trades.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? cbApiKey = envVars['COINBASE_API_KEY'];
String? cbApiSecret = envVars['COINBASE_API_SECRET'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials = Credential(cbApiKey!, cbApiSecret!);

void main() {
  group('Test Get Trades Requests to Coinbase AT API', skip: skip, () {
    test('Authorized Get Trades', () async {
      String productId = 'BTC-USD';
      String requestPath = '/products/$productId/ticker';
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);

      expect(true, isTrue);
    });

    test('Authorized Get Trades', () async {
      String productId = 'MEDIA-USD';
      List<Trade?> trades = await getTrades(
          productId: productId, credential: credentials, isSandbox: true);
      print('Products: $trades');
      expect(trades.isNotEmpty, true);
    });

    test('Authorized Get Trades with limit', () async {
      int limit = 100;
      String productId = 'BTC-USD';
      List<Trade?> trades = await getTrades(
          productId: productId,
          limit: limit,
          credential: credentials,
          isSandbox: true);
      print('Trades: $trades');
      expect(trades.isNotEmpty, true);
      expect(trades.length, 100);
    });

    test('Get Trade by Product ID', () async {
      String productId = 'BTC-USD';
      List<Trade?> trades = await getTrades(
          productId: productId, credential: credentials, isSandbox: true);

      print('Trade : $trades');
      expect(trades.first?.productId, productId);
    });

    test('Get Trade by Product ID II', () async {
      List<Product?> originProducts =
          await getProducts(credential: credentials, isSandbox: true);

      String? productId = originProducts.first?.productId;
      List<Trade?> trades = await getTrades(
          productId: productId, credential: credentials, isSandbox: true);

      print('Trades : $trades');
      expect(trades.first?.productId!, productId);
    });
  });
}
