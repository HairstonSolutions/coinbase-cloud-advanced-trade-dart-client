import 'dart:convert';
import 'dart:io' show Platform;
import 'package:logging/logging.dart';
import '../../test_helpers.dart';
import '../../test_constants.dart' as testConstants;

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/trades.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'trades_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('trades_test');

  group('Test Get Trades using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get trades for a product', () async {
      final mockResponse = {
        "trades": [
          {
            "trade_id": "123456",
            "product_id": "BTC-USD",
            "price": "50000.00",
            "size": "0.01",
            "time": "2021-05-31T09:59:59Z",
            "side": "BUY",
            "bid": "49999.00",
            "ask": "50001.00",
            "volume": "1000",
          }
        ],
        "best_bid": "49999.00",
        "best_ask": "50001.00"
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      List<Trade?> trades = await getTrades(
          productId: "BTC-USD", client: mockClient, credential: testConstants.credentials);

      expect(trades, isNotNull);
      expect(trades.length, 1);
      expect(trades[0]?.tradeId, "123456");
      expect(trades[0]?.productId, "BTC-USD");
    });
  });

  group('Test Get Trades Requests to Coinbase AT API Endpoints', skip: testConstants.ciSkip,
      () {
    test('Authorized Get Trades', () async {
      String productId = 'BTC-USD';
      String requestPath = '/products/$productId/ticker';
      var response = await getAuthorized(requestPath,
          credential: testConstants.credentials, isSandbox: false);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);

      expect(true, isTrue);
    });

    test('Authorized Get Trades', () async {
      String productId = 'BTC-USD';
      List<Trade?> trades = await getTrades(
          productId: productId, credential: testConstants.credentials, isSandbox: false);
      logger.info('Products: $trades');
      expect(trades.isNotEmpty, true);
    });

    test('Authorized Get Trades with limit', () async {
      int limit = 100;
      String productId = 'BTC-USD';
      List<Trade?> trades = await getTrades(
          productId: productId,
          limit: limit,
          credential: testConstants.credentials,
          isSandbox: false);
      logger.info('Trades: $trades');
      expect(trades.isNotEmpty, true);
      expect(trades.length, 100);
    });

    test('Get Trade by Product ID', () async {
      String productId = 'BTC-USD';
      List<Trade?> trades = await getTrades(
          productId: productId, credential: testConstants.credentials, isSandbox: false);

      logger.info('Trade : $trades');
      expect(trades.first?.productId, productId);
    });

    test('Get Trade by Product ID II', () async {
      List<Product?> originProducts = await getProductsAuthorized(
          credential: testConstants.credentials, isSandbox: false);

      String? productId = originProducts.first?.productId;
      List<Trade?> trades = await getTrades(
          productId: productId, credential: testConstants.credentials, isSandbox: false);

      logger.info('Trades : $trades');
      expect(trades.first?.productId!, productId);
    });
  });
}
