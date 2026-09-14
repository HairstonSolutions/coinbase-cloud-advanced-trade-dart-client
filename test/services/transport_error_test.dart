import 'dart:io';

import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../test_constants.dart' as constants;
import '../test_helpers.dart';

/// A [MockClient] whose handler always throws [error].
MockClient throwingClient(Object error) =>
    MockClient((request) async => throw error);

void main() {
  final Logger logger = setupLogger('transport_error_test');

  group('Network helpers map transport failures to CoinbaseTransportException',
      () {
    test('An unauthorized get wraps http.ClientException', () async {
      final error = http.ClientException('connection reset');

      try {
        await get('/test_endpoint',
            options: CoinbaseHttpOptions(client: throwingClient(error)));
        fail('Should have thrown CoinbaseTransportException');
      } on CoinbaseTransportException catch (e) {
        logger.info('Caught: $e');
        expect(e.method, 'GET');
        expect(e.path, '/api/v3/brokerage/test_endpoint');
        expect(e.cause, same(error));
      }
    });

    test('An authorized get wraps SocketException', () async {
      final error = const SocketException('connection refused');

      try {
        await getAuthorized('/test_endpoint',
            options: CoinbaseHttpOptions(client: throwingClient(error)),
            credential: constants.credentials);
        fail('Should have thrown CoinbaseTransportException');
      } on CoinbaseTransportException catch (e) {
        logger.info('Caught: $e');
        expect(e.method, 'GET');
        expect(e.path, '/api/v3/brokerage/test_endpoint');
        expect(e.cause, same(error));
      }
    });

    test('An authorized post wraps HandshakeException', () async {
      final error = const HandshakeException('certificate verify failed');

      try {
        await postAuthorized('/test_endpoint',
            body: '{}',
            options: CoinbaseHttpOptions(client: throwingClient(error)),
            credential: constants.credentials);
        fail('Should have thrown CoinbaseTransportException');
      } on CoinbaseTransportException catch (e) {
        logger.info('Caught: $e');
        expect(e.method, 'POST');
        expect(e.cause, same(error));
      }
    });

    test('An authorized put wraps TlsException', () async {
      final error = const TlsException('tls failure');

      try {
        await putAuthorized('/test_endpoint',
            body: '{}',
            options: CoinbaseHttpOptions(client: throwingClient(error)),
            credential: constants.credentials);
        fail('Should have thrown CoinbaseTransportException');
      } on CoinbaseTransportException catch (e) {
        logger.info('Caught: $e');
        expect(e.method, 'PUT');
        expect(e.cause, same(error));
      }
    });

    test('An authorized delete wraps http.ClientException', () async {
      final error = http.ClientException('connection reset');

      try {
        await deleteAuthorized('/test_endpoint',
            options: CoinbaseHttpOptions(client: throwingClient(error)),
            credential: constants.credentials);
        fail('Should have thrown CoinbaseTransportException');
      } on CoinbaseTransportException catch (e) {
        logger.info('Caught: $e');
        expect(e.method, 'DELETE');
        expect(e.cause, same(error));
      }
    });

    test('The path reported is the path of a custom base URL', () async {
      final error = http.ClientException('connection reset');

      try {
        await getAuthorized('/test_endpoint',
            options: CoinbaseHttpOptions(
                baseUrl: Uri.parse('http://localhost:1234/proxy'),
                client: throwingClient(error)),
            credential: constants.credentials);
        fail('Should have thrown CoinbaseTransportException');
      } on CoinbaseTransportException catch (e) {
        logger.info('Caught: $e');
        expect(e.path, '/proxy/api/v3/brokerage/test_endpoint');
      }
    });

    test('CoinbaseTransportException is a CoinbaseException', () async {
      try {
        await get('/test_endpoint',
            options: CoinbaseHttpOptions(
                client: throwingClient(http.ClientException('reset'))));
        fail('Should have thrown CoinbaseTransportException');
      } on CoinbaseException catch (e) {
        expect(e, isA<CoinbaseTransportException>());
        expect(e.statusCode, 0);
        expect(e.toString(), contains('GET'));
        expect(e.toString(), contains('reset'));
      }
    });

    test('A timeout still throws CoinbaseTimeoutException', () async {
      final mockClient = MockClient((request) async {
        await Future.delayed(const Duration(seconds: 2));
        return http.Response('{}', 200);
      });

      await expectLater(
        get('/test_endpoint',
            options: CoinbaseHttpOptions(
                timeout: const Duration(milliseconds: 100),
                client: mockClient)),
        throwsA(isA<CoinbaseTimeoutException>()),
      );
    });

    test('Errors that are not transport failures are not wrapped', () async {
      final error = StateError('a programming error');

      await expectLater(
        get('/test_endpoint',
            options: CoinbaseHttpOptions(client: throwingClient(error))),
        throwsA(isA<StateError>()),
      );
    });

    test('A successful response is returned unchanged', () async {
      final mockClient =
          MockClient((request) async => http.Response('{"ok": true}', 200));

      final response = await get('/test_endpoint',
          options: CoinbaseHttpOptions(client: mockClient));

      expect(response.statusCode, 200);
      expect(response.body, '{"ok": true}');
    });
  });

  group('REST functions surface CoinbaseTransportException', () {
    test('getOrdersPage throws CoinbaseTransportException with the cause',
        () async {
      final error = http.ClientException('connection reset');

      try {
        await getOrdersPage(
            options: CoinbaseHttpOptions(client: throwingClient(error)),
            credential: constants.credentials);
        fail('Should have thrown CoinbaseTransportException');
      } on CoinbaseTransportException catch (e) {
        logger.info('Caught: $e');
        expect(e.method, 'GET');
        expect(e.path, '/api/v3/brokerage/orders/historical/batch');
        expect(e.cause, same(error));
        expect(e.cause, isA<http.ClientException>());
      }
    });

    test('getAccountsPage throws CoinbaseTransportException', () async {
      final error = const SocketException('connection refused');

      await expectLater(
        getAccountsPage(
            options: CoinbaseHttpOptions(client: throwingClient(error)),
            credential: constants.credentials),
        throwsA(isA<CoinbaseTransportException>()),
      );
    });
  });
}
