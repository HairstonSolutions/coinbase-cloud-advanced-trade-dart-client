import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/products/trades.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package.test/test.dart';

import '../../../mocks.mocks.dart';

// Use a dummy credential for mock tests
final Credential credentials =
    Credential(apiKeyName: 'api_key_name', privateKeyPEM: 'private_key');

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
}