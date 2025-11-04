import 'package:coinbase_cloud_advanced_trade_client/src/rest/public.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../tools.dart';
import 'public_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Public REST Tests', () {
    test('Get Server Time', () async {
      final client = MockClient();
      final String productBookJson =
          await getJsonFromFile('test/rest/public/server_time.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productBookJson, 200));

      final serverTime = await getServerTime(client: client);

      expect(serverTime, isNotNull);
      expect(serverTime!.iso, isNotNull);
      expect(serverTime.epochSeconds, isNotNull);
      expect(serverTime.epochMillis, isNotNull);
    });

    test('List Products', () async {
      final client = MockClient();
      final String productsJson =
          await getJsonFromFile('test/rest/public/list_products.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productsJson, 200));

      final products = await listProducts(client: client);

      expect(products, isNotNull);
      expect(products!.products, isNotNull);
      expect(products.products.isNotEmpty, isTrue);
      expect(products.products[0].productId, isNotNull);
    });

    test('Get Product', () async {
      final client = MockClient();
      final String productJson =
          await getJsonFromFile('test/rest/public/get_product.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productJson, 200));

      final product = await getProduct(client: client, productId: 'BTC-USD');

      expect(product, isNotNull);
      expect(product!.productId, isNotNull);
    });

    test('Get Product Book', () async {
      final client = MockClient();
      final String productBookJson =
          await getJsonFromFile('test/rest/public/get_product_book.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productBookJson, 200));

      final productBook =
          await getProductBook(client: client, productId: 'BTC-USD');

      expect(productBook, isNotNull);
      expect(productBook!.pricebook.productId, isNotNull);
      expect(productBook.pricebook, isNotNull);
      expect(productBook.pricebook.bids, isNotNull);
      expect(productBook.pricebook.asks, isNotNull);
    });

    test('Get Product Candles', () async {
      final client = MockClient();
      final String productCandlesJson =
          await getJsonFromFile('test/rest/public/get_product_candles.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productCandlesJson, 200));

      final productCandles = await getProductCandles(
          client: client,
          productId: 'BTC-USD',
          start: '1609459200',
          end: '1609545600',
          granularity: 'ONE_MINUTE');

      expect(productCandles, isNotNull);
      expect(productCandles!.candles, isNotNull);
      expect(productCandles.candles.isNotEmpty, isTrue);
    });

    test('Get Market Trades', () async {
      final client = MockClient();
      final String marketTradesJson =
          await getJsonFromFile('test/rest/public/get_market_trades.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(marketTradesJson, 200));

      final marketTrades =
          await getMarketTrades(client: client, productId: 'BTC-USD', limit: 1);

      expect(marketTrades, isNotNull);
      expect(marketTrades!.trades, isNotNull);
      expect(marketTrades.trades.isNotEmpty, isTrue);
    });
  });
}
