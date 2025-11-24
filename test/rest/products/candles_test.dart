import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/public/products.dart'
    as public;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

void main() {
  final Logger logger = setupLogger('candles_test');

  group('Product Candles', () {
    // Mock Tests
    group('Mocks', () {
      test('Get Product Candles (Public)', () async {
        final client = MockClient();
        final String mockResponse =
            await getJsonFromFile('rest/products/get_product_candles.json');

        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(mockResponse, 200));

        final candles = await public.getProductCandles(
          productId: 'BTC-USD',
          start: '1672531200',
          end: '1672617600',
          granularity: 'ONE_HOUR',
          client: client,
        );

        expect(candles.length, 1);
        expect(candles[0].start, "1672531200");
      });

      test('Get Product Candles (Private)', () async {
        final client = MockClient();
        final String mockResponse =
            await getJsonFromFile('rest/products/get_product_candles.json');
        final credential = constants.credentials;

        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(mockResponse, 200));

        final candles = await getProductCandlesAuthorized(
          productId: 'BTC-USD',
          start: '1672531200',
          end: '1672617600',
          granularity: 'ONE_HOUR',
          credential: credential,
          client: client,
        );

        expect(candles.length, 1);
        expect(candles[0].start, "1672531200");
      });
    });

    // Integration Tests
    group('Integration', () {
      test('Get Product Candles (Public)', () async {
        final candles = await public.getProductCandles(
          productId: 'BTC-USD',
          start: '1672531200',
          end: '1672617600',
          granularity: 'ONE_HOUR',
        );

        logger.info(candles);
        expect(candles.length, greaterThan(0));
      });

      group('Get Product Candles (Private)', () {
        late Credential credential;

        setUp(() {
          if (!constants.ciSkip) {
            credential = constants.credentials;
          }
        });

        test('Get Candles', () async {
          final candles = await getProductCandlesAuthorized(
            productId: 'BTC-USD',
            start: '1672531200',
            end: '1672617600',
            granularity: 'ONE_HOUR',
            credential: credential,
          );

          logger.info(candles);
          expect(candles.length, greaterThan(0));
        });
      }, skip: constants.ciSkip);
    });
  });
}
