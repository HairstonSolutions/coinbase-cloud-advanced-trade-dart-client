import 'dart:convert';
import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/trades.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';

final Map<String, String> envVars = Platform.environment;
final String apiKeyName = envVars['COINBASE_API_KEY_NAME'] ?? 'api_key_name';
final String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];
final String? skipTests = envVars['SKIP_TESTS'];
final bool skip = skipTests == 'false' ? false : true;

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM!);

void main() {
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
          productId: "BTC-USD", client: mockClient, credential: credentials);

      expect(trades, isNotNull);
      expect(trades.length, 1);
      expect(trades[0]?.tradeId, "123456");
      expect(trades[0]?.productId, "BTC-USD");
    });
  });

  group('Test Get Trades Requests to Coinbase AT API', skip: skip, () {
    test('Authorized Get Trades', () async {
      String productId = 'BTC-USD';
      String requestPath = '/products/$productId/ticker';
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: false);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);

      expect(true, isTrue);
    });

    test('Authorized Get Trades', () async {
      String productId = 'BTC-USD';
      List<Trade?> trades = await getTrades(
          productId: productId, credential: credentials, isSandbox: false);
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
          isSandbox: false);
      print('Trades: $trades');
      expect(trades.isNotEmpty, true);
      expect(trades.length, 100);
    });

    test('Get Trade by Product ID', () async {
      String productId = 'BTC-USD';
      List<Trade?> trades = await getTrades(
          productId: productId, credential: credentials, isSandbox: false);

      print('Trade : $trades');
      expect(trades.first?.productId, productId);
    });

    test('Get Trade by Product ID II', () async {
      List<Product?> originProducts = await getProductsAuthorized(
          credential: credentials, isSandbox: false);

      String? productId = originProducts.first?.productId;
      List<Trade?> trades = await getTrades(
          productId: productId, credential: credentials, isSandbox: false);

      print('Trades : $trades');
      expect(trades.first?.productId!, productId);
    });
  });
}
