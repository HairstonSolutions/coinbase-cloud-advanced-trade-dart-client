import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product_book.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../product_book_test.mocks.dart';
import '../../test_constants.dart' as constants;

@GenerateMocks([http.Client])
void main() {
  final Logger logger = Logger('best_bid_ask_test');
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  group('Best Bid Ask Tests', () {
    test('Get Best Bid Ask Authorized', () async {
      final client = MockClient();
      final List<String> productIds = ['BTC-USD', 'ETH-USD'];

      when(client.get(
        Uri.https('api.coinbase.com', '/api/v3/brokerage/best_bid_ask', {
          'product_ids': ['BTC-USD', 'ETH-USD']
        }),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          jsonEncode({
            "pricebooks": [
              {
                "product_id": "BTC-USD",
                "bids": [
                  {"price": "10000.00", "size": "1"}
                ],
                "asks": [
                  {"price": "10001.00", "size": "1"}
                ],
                "time": "2023-01-01T00:00:00Z"
              },
              {
                "product_id": "ETH-USD",
                "bids": [
                  {"price": "1000.00", "size": "10"}
                ],
                "asks": [
                  {"price": "1001.00", "size": "10"}
                ],
                "time": "2023-01-01T00:00:00Z"
              }
            ]
          }),
          200));

      List<ProductBook> productBooks = await getBestBidAsk(
          productIds: productIds,
          client: client,
          credential: Credential(
              apiKeyName: 'key', privateKeyPEM: constants.privateKeyPEM));

      expect(productBooks.length, 2);

      expect(productBooks[0].productId, equals('BTC-USD'));
      expect(productBooks[0].bids.length, 1);
      expect(productBooks[0].asks.length, 1);
      expect(productBooks[0].time, isNotNull);

      expect(productBooks[1].productId, equals('ETH-USD'));
      expect(productBooks[1].bids.length, 1);
      expect(productBooks[1].asks.length, 1);
      expect(productBooks[1].time, isNotNull);
    });
  });

  group('Best Bid Ask Integration Tests', skip: constants.ciSkip, () {
    test('Get Best Bid Ask Authorized', () async {
      final List<String> productIds = ['BTC-USD', 'ETH-USD'];

      List<ProductBook> productBooks = await getBestBidAsk(
          productIds: productIds, credential: constants.credentials);

      logger.info('Best Bid Ask: $productBooks');

      expect(productBooks.length, 2);

      final productIdsFound = productBooks.map((p) => p.productId).toList();
      expect(productIdsFound, unorderedEquals(['BTC-USD', 'ETH-USD']));

      for (var book in productBooks) {
        expect(book.bids.length, 1);
        expect(book.asks.length, 1);
        expect(book.time, isNotNull);
      }
    });
  });
}
