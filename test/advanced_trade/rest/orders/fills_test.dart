import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/fill.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/orders/fills.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../mocks.mocks.dart';

// Use a dummy credential for mock tests
final Credential credentials =
    Credential(apiKeyName: 'api_key_name', privateKeyPEM: 'private_key');

void main() {
  group('Test Get Fills using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of fills', () async {
      final mockResponse = {
        "fills": [
          {
            "order_id": "b0313b63-a2a1-4d30-a506-936337b52978",
            "trade_id": "123456",
            "product_id": "BTC-USD",
            "price": "50000.00",
            "size": "0.01",
            "fee": "0.50",
            "side": "BUY",
            "liquidity_indicator": "TAKER",
            "trade_time": "2021-05-31T09:59:59Z"
          }
        ],
        "cursor": "some-cursor-for-next-page"
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      List<Fill>? fills =
          await getFills(client: mockClient, credential: credentials);

      expect(fills, isNotNull);
      expect(fills?.length, 1);
      expect(fills?[0].orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
    });
  });
}