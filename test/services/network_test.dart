import 'package:coinbase_cloud_advanced_trade_client/src/models/coinbase_http_options.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../test_constants.dart' as constants;
import '../test_helpers.dart';

void main() {
  final Logger logger = setupLogger('network_test');

  group('Test Network Service', skip: constants.ciSkip, () {
    setUp(() {});

    test('Authorized Get with no body (Fees)', () async {
      String requestPath = "/transaction_summary";
      var response = await getAuthorized(requestPath,
          credential: constants.credentials, isSandbox: false);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized Get to Accounts', () async {
      String requestPath = "/accounts";
      var response = await getAuthorized(requestPath,
          credential: constants.credentials, isSandbox: true);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized Get to Sandbox Accounts', () async {
      String requestPath = "/accounts";
      var response = await getAuthorized(requestPath,
          credential: constants.credentials, isSandbox: true);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });
  });

  group('CoinbaseHttpOptions Tests', () {
    test('Custom base URL sends to the custom host', () async {
      String requestPath = "/test_endpoint";
      Uri customBaseUrl = Uri.parse('http://localhost:8080');

      var mockClient = MockClient((request) async {
        expect(request.url.host, 'localhost');
        expect(request.url.port, 8080);
        expect(request.url.path, '/api/v3/brokerage/test_endpoint');
        return http.Response('{}', 200);
      });

      var options = CoinbaseHttpOptions(
        baseUrl: customBaseUrl,
        client: mockClient,
      );

      var response = await getAuthorized(requestPath,
          options: options, credential: constants.credentials);

      expect(response.statusCode, 200);
    });

    test(
        'A hung client throws CoinbaseTimeoutException after configured timeout',
        () async {
      String requestPath = "/test_endpoint";

      var mockClient = MockClient((request) async {
        await Future.delayed(Duration(seconds: 2));
        return http.Response('{}', 200);
      });

      var options = CoinbaseHttpOptions(
        timeout: Duration(milliseconds: 100),
        client: mockClient,
      );

      expect(
        () async => await getAuthorized(requestPath,
            options: options, credential: constants.credentials),
        throwsA(isA<CoinbaseTimeoutException>()),
      );
    });

    test(
        'HTTP 429 response parses Retry-After header into a Duration on CoinbaseException',
        () async {
      String requestPath = "/test_endpoint";

      var mockClient = MockClient((request) async {
        return http.Response('Rate limit exceeded', 429, headers: {
          'retry-after': '2',
        });
      });

      var options = CoinbaseHttpOptions(
        client: mockClient,
      );

      try {
        await getAuthorized(requestPath,
            options: options, credential: constants.credentials);
        fail('Should have thrown CoinbaseException');
      } catch (e) {
        expect(e, isA<CoinbaseException>());
        var exception = e as CoinbaseException;
        expect(exception.statusCode, 429);
        expect(exception.retryAfter, Duration(seconds: 2));
        expect(exception.toString(), contains('Retry-After: 0:00:02.000000'));
      }
    });
  });
}
