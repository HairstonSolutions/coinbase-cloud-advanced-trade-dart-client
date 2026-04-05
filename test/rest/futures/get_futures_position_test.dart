import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../mocks/futures_position.dart';

void main() {
  group('getFuturesPosition Mocks', () {
    test('successfully parses a mocked response', () async {
      final mockClient = MockClient();

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(getFuturesPositionMock, 200, headers: {'content-type': 'application/json'}));


      final position = await getFuturesPosition(
        productId: 'BIT-28JUL23-CDE',
        credential: constants.credentials,
        client: mockClient,
      );

      expect(position.productId, 'BIT-28JUL23-CDE');
      expect(position.expirationTime, '2023-07-28T08:00:00Z');
      expect(position.side, 'LONG');
      expect(position.numberOfContracts, '5');
      expect(position.currentPrice, '30000.50');
      expect(position.avgEntryPrice, '29000.00');
      expect(position.unrealizedPnl, '5002.50');
      expect(position.dailyRealizedPnl, '100.00');
    });

    test('throws CoinbaseException on failure', () async {
      final mockClient = MockClient();

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response('{"error": "Unauthorized"}', 401));

      expect(
        () async => await getFuturesPosition(
          productId: 'BIT-28JUL23-CDE',
          credential: constants.credentials,
          client: mockClient,
        ),
        throwsA(isA<CoinbaseException>()),
      );
    });
  });

  group('getFuturesPosition Live', skip: constants.ciSkip, () {
    test('integration test with live API (requires valid credentials)', () async {
      try {
         await getFuturesPosition(
            productId: 'BIT-28JUL23-CDE',
            credential: constants.credentials,
         );
      } catch (e) {
          expect(e, isA<CoinbaseException>());
      }
    });
  });
}
