import 'dart:convert';
import 'dart:io';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product_book.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('best_bid_ask_test');

  group('Best Bid Ask Tests', () {
    test('Get Best Bid Ask Authorized', () async {
      final client = MockClient();
      final List<String> productIds = ['BTC-USD', 'ETH-USD'];

      final String mockResponse =
          await getJsonFromFile('rest/products/get_best_bid_ask.json');

      when(client.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

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

    test('Get Best Bid Ask Throws CoinbaseException on Error', () async {
      final client = MockClient();
      final List<String> productIds = ['BTC-USD'];

      when(client.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode('Internal Server Error')), 500,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      expect(
          () async => await getBestBidAsk(
              productIds: productIds,
              client: client,
              credential: Credential(
                  apiKeyName: 'key', privateKeyPEM: constants.privateKeyPEM)),
          throwsA(isA<CoinbaseException>()));
    });
  });

  group('Best Bid Ask Integration Tests', skip: constants.ciSkip, () {
    test('Get Best Bid Ask Authorized', () async {
      final List<String> productIds = ['BTC-USD', 'ETH-USD'];

      List<ProductBook> productBooks = await getBestBidAsk(
          productIds: productIds, credential: constants.credentials);

      logger.info('Best Bid Ask: $productBooks');

      expect(productBooks, isNotNull);
      expect(productBooks.length, 2);

      final productIdsFound = productBooks.map((p) => p.productId).toList();
      expect(productIdsFound, unorderedEquals(['BTC-USD', 'ETH-USD']));

      for (var book in productBooks) {
        expect(book.bids.length, greaterThanOrEqualTo(0));
        expect(book.asks.length, greaterThanOrEqualTo(0));
        expect(book.time, isNotNull);
      }
    });
  });
}
