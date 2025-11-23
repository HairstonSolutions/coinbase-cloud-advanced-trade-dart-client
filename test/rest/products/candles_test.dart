import 'dart:io';
import 'package:logging/logging.dart';
import '../../test_helpers.dart';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/public/products.dart'
    as public;
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../test_constants.dart';
import '../../mocks.mocks.dart';

void main() {
  final Logger logger = setupLogger('candles_test');

  group('Product Candles', () {
    // Mock Tests
    group('Mocks', () {
      test('Get Product Candles (Public)', () async {
        final client = MockClient();
        final mockResponse =
            '{"candles":[{"start":"1672531200","high":"16600","low":"16500","open":"16550","close":"16580","volume":"1234.56"}]}';

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
        final mockResponse =
            '{"candles":[{"start":"1672531200","high":"16600","low":"16500","open":"16550","close":"16580","volume":"1234.56"}]}';
        final credential =
            Credential(apiKeyName: 'key', privateKeyPEM: privateKeyPEM);

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
          if (!ciSkip) {
            final apiKeyName = Platform.environment['COINBASE_API_KEY_NAME']!;
            final privateKeyPEM = Platform.environment['COINBASE_PRIVATE_KEY']!;
            credential = Credential(
                apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);
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
      }, skip: ciSkip);
    });
  });
}
