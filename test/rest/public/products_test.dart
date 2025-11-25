import 'dart:io';

import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/ticker.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/public/products.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart';
import '../../test_helpers.dart';
import '../../tools.dart';

const String testTicker =
    '{"trades":[{"trade_id":"testId","product_id":"BTC-USD","price":"100.00","size":"1","time":"2021-01-01T00:00:00Z","side":"BUY","bid":"99.99","ask":"100.01"}],"best_bid":"100.00","best_ask":"101.00"}';
const String testError = '{"error":"test error"}';
const Map<String, String> testHeader = {'Content-Type': 'application/json'};

void main() {
  final Logger logger = setupLogger('public_products_test');

  group('Public Products using Mocks', () {
    test('Get Product', () async {
      final client = MockClient();
      final String productJson =
          await getJsonFromFile('rest/public/get_product.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productJson, 200));

      final product = await getProduct(productId: 'BTC-USD', client: client);

      expect(product, isNotNull);
      expect(product!.productId, 'BTC-USD');
    });

    test('Get Products', () async {
      final client = MockClient();
      final String productsJson =
          await getJsonFromFile('rest/public/get_products.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productsJson, 200));

      final products = await getProducts(client: client);

      expect(products, isNotNull);
      expect(products, isNotEmpty);
    });

    test('Get Market Trades - Success', () async {
      final client = MockClient();
      final successResponse =
          http.Response(testTicker, 200, headers: testHeader);

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => successResponse);

      Ticker? ticker =
          await getMarketTrades(productId: 'BTC-USD', limit: 1, client: client);

      expect(ticker, isNot(null));
      expect(ticker?.trades?[0].tradeId, equals('testId'));
      expect(ticker?.bestBid, equals(100.00));
      expect(ticker?.bestAsk, equals(101.00));
    });

    test('Get Market Trades - Failure', () async {
      final client = MockClient();
      final failureResponse =
          http.Response(testError, 404, headers: testHeader);

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => failureResponse);

      final future =
          getMarketTrades(productId: 'BTC-USD', limit: 1, client: client);
      expect(
          future,
          throwsA(isA<CoinbaseException>()
              .having((e) => e.statusCode, 'statusCode', 404)));
    });
  });

  group('Public REST Tests Requests to Coinbase AT API Endpoints', () {
    test('Get Product', () async {
      final product = await getProduct(productId: 'BTC-USD');

      logger.info('Product: $product');

      expect(product, isNotNull);
      expect(product!.productId, 'BTC-USD');
    });

    test('Get Products', () async {
      final products = await getProducts();

      logger.info('Products: $products');

      expect(products, isNotNull);
      expect(products, isNotEmpty);
    });

    test('Get Market Trades', () async {
      Ticker? ticker = await getMarketTrades(productId: 'BTC-USD', limit: 1);

      logger.info('Ticker: $ticker');
      expect(ticker, isNot(null));
    });
  });
}
