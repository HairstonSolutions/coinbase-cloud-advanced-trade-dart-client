import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/product_book.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/public/products.dart'
    as public;
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart'
    as authorized;
import 'dart:io' show Platform;
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'test_constants.dart' as constants;

import 'product_book_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late Credential credentials;

  setUp(() {
    if (!constants.ciSkip) {
      credentials = Credential(
          apiKeyName: constants.apiKeyName,
          privateKeyPEM: constants.privateKeyPEM);
    }
  });

  group('Product Book Tests', () {
    test('Get Public Product Book', () async {
      final client = MockClient();
      final String productId = 'BTC-USD';
      final int limit = 1;

      when(client.get(
        Uri.https('api.coinbase.com',
            '/api/v3/brokerage/market/product_book', {'product_id': productId, 'limit': '$limit'}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          jsonEncode({
            "pricebook": {
              "product_id": "BTC-USD",
              "bids": [
                {"price": "10000.00", "size": "1"}
              ],
              "asks": [
                {"price": "10001.00", "size": "1"}
              ]
            }
          }),
          200));

      ProductBook? productBook = await public.getProductBook(
          productId: productId, limit: limit, client: client);

      expect(productBook, isNotNull);
      expect(productBook!.productId, equals('BTC-USD'));
      expect(productBook.bids.length, 1);
      expect(productBook.asks.length, 1);
    });

    test('Get Authorized Product Book', () async {
      final client = MockClient();
      final String productId = 'BTC-USD';
      final int limit = 1;

      when(client.get(
        Uri.https('api.coinbase.com',
            '/api/v3/brokerage/products/book', {'product_id': productId, 'limit': '$limit'}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          jsonEncode({
            "pricebook": {
              "product_id": "BTC-USD",
              "bids": [
                {"price": "10000.00", "size": "1"}
              ],
              "asks": [
                {"price": "10001.00", "size": "1"}
              ]
            }
          }),
          200));

      ProductBook? productBook = await authorized.getProductBookAuthorized(
          productId: productId,
          limit: limit,
          client: client,
          credential: Credential(apiKeyName: 'key', privateKeyPEM: constants.privateKeyPEM));

      expect(productBook, isNotNull);
      expect(productBook!.productId, equals('BTC-USD'));
      expect(productBook.bids.length, 1);
      expect(productBook.asks.length, 1);
    });

    test('Test toString()', () {
      ProductBook productBook = ProductBook(
        productId: 'BTC-USD',
        bids: [PriceLevel(price: '10000.00', size: '1')],
        asks: [PriceLevel(price: '10001.00', size: '1')],
      );

      String expectedString =
          '{productId: BTC-USD, bids: [{price: 10000.00, size: 1}], asks: [{price: 10001.00, size: 1}]}';

      expect(productBook.toString(), equals(expectedString));
    });
  });

  group('Product Book Integration Tests', skip: constants.ciSkip, () {
    test('Get Public Product Book', () async {
      final String productId = 'BTC-USD';
      final int limit = 1;

      ProductBook? productBook =
          await public.getProductBook(productId: productId, limit: limit);

      print('Public Product Book: $productBook');
      expect(productBook, isNotNull);
      expect(productBook!.productId, isNotNull);
      expect(productBook.bids, isNotNull);
      expect(productBook.asks, isNotNull);
    });

    test('Get Authorized Product Book', () async {
      final String productId = 'BTC-USD';
      final int limit = 1;

      ProductBook? productBook = await authorized.getProductBookAuthorized(
          productId: productId, limit: limit, credential: credentials);

      print('Authorized Product Book: $productBook');
      expect(productBook, isNotNull);
      expect(productBook!.productId, isNotNull);
      expect(productBook.bids, isNotNull);
      expect(productBook.asks, isNotNull);
    });
  });
}
