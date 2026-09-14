import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/create_order_result.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../test_constants.dart' as constants;
import '../test_helpers.dart';
import '../tools.dart';

/// Decodes the claims of a JWT without verifying its signature.
Map<String, dynamic> decodeJwtClaims(String jwt) {
  final String payload = jwt.split('.')[1];
  return jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(payload))))
      as Map<String, dynamic>;
}

/// Returns the 'uri' claim of the JWT in an Authorization header.
String jwtUriClaim(Map<String, String> headers) {
  final String bearer = headers['Authorization']!;
  return decodeJwtClaims(bearer.substring('Bearer '.length))['uri'] as String;
}

void main() {
  final Logger logger = setupLogger('http_options_test');

  final Uri customBaseUrl = Uri.parse('http://localhost:1234');

  group('REST functions honour CoinbaseHttpOptions using Mocks', () {
    test('getOrdersPage sends the request to the custom base URL', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_orders_page_1.json');

      late http.BaseRequest capturedRequest;
      final mockClient = MockClient((request) async {
        capturedRequest = request;
        return http.Response(mockResponse, 200);
      });

      final page = await getOrdersPage(
          options:
              CoinbaseHttpOptions(baseUrl: customBaseUrl, client: mockClient),
          credential: constants.credentials);

      expect(capturedRequest.url.host, 'localhost');
      expect(capturedRequest.url.port, 1234);
      expect(capturedRequest.url.scheme, 'http');
      expect(capturedRequest.url.path,
          '/api/v3/brokerage/orders/historical/batch');
      expect(page.items.length, 1);
    });

    test('getOrdersPage signs the JWT with the custom host', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_orders_page_1.json');

      late String uriClaim;
      final mockClient = MockClient((request) async {
        uriClaim = jwtUriClaim(request.headers);
        return http.Response(mockResponse, 200);
      });

      await getOrdersPage(
          options:
              CoinbaseHttpOptions(baseUrl: customBaseUrl, client: mockClient),
          credential: constants.credentials);

      logger.info('JWT uri claim: $uriClaim');
      expect(uriClaim,
          'GET localhost:1234/api/v3/brokerage/orders/historical/batch');
    });

    test(
        'createLimitOrder sends the request to the custom base URL and signs '
        'the JWT with the custom host', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/create_order_success.json');

      late http.BaseRequest capturedRequest;
      late String uriClaim;
      final mockClient = MockClient((request) async {
        capturedRequest = request;
        uriClaim = jwtUriClaim(request.headers);
        return http.Response(mockResponse, 200);
      });

      final result = await createLimitOrder(
        clientOrderId: 'client-id-123',
        productId: 'BTC-USD',
        side: OrderSide.buy,
        baseSize: '0.1',
        limitPrice: '10000',
        credential: constants.credentials,
        options:
            CoinbaseHttpOptions(baseUrl: customBaseUrl, client: mockClient),
      );

      logger.info('JWT uri claim: $uriClaim');
      expect(capturedRequest.method, 'POST');
      expect(capturedRequest.url.host, 'localhost');
      expect(capturedRequest.url.port, 1234);
      expect(capturedRequest.url.path, '/api/v3/brokerage/orders');
      expect(uriClaim, 'POST localhost:1234/api/v3/brokerage/orders');
      expect(result, isA<OrderSuccess>());
    });

    test(
        'getProduct (public endpoint) sends the request to the custom base URL',
        () async {
      final String mockResponse =
          await getJsonFromFile('rest/public/get_product.json');

      late http.BaseRequest capturedRequest;
      final mockClient = MockClient((request) async {
        capturedRequest = request;
        return http.Response(mockResponse, 200);
      });

      final product = await getProduct(
          productId: 'BTC-USD',
          options:
              CoinbaseHttpOptions(baseUrl: customBaseUrl, client: mockClient));

      expect(capturedRequest.url.host, 'localhost');
      expect(capturedRequest.url.port, 1234);
      expect(capturedRequest.url.path,
          '/api/v3/brokerage/market/products/BTC-USD');
      expect(product, isNotNull);
    });

    test('getOrdersPage throws CoinbaseTimeoutException when the client hangs',
        () async {
      final mockClient = MockClient((request) async {
        await Future.delayed(const Duration(seconds: 30));
        return http.Response('{}', 200);
      });

      await expectLater(
        getOrdersPage(
            options: CoinbaseHttpOptions(
                timeout: const Duration(milliseconds: 100), client: mockClient),
            credential: constants.credentials),
        throwsA(isA<CoinbaseTimeoutException>()),
      );
    });

    test('getAccountsPage forwards options to the network layer', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_accounts.json');

      late String uriClaim;
      final mockClient = MockClient((request) async {
        uriClaim = jwtUriClaim(request.headers);
        return http.Response(mockResponse, 200);
      });

      final page = await getAccountsPage(
          options:
              CoinbaseHttpOptions(baseUrl: customBaseUrl, client: mockClient),
          credential: constants.credentials);

      expect(uriClaim, 'GET localhost:1234/api/v3/brokerage/accounts');
      expect(page.items, isNotEmpty);
    });
  });

  group('Public REST Requests to Coinbase AT API Endpoints with options', () {
    test('Get Server Time with a configured timeout', () async {
      final serverTime = await getServerTime(
          options: const CoinbaseHttpOptions(timeout: Duration(seconds: 30)));

      logger.info('Server Time: $serverTime');

      expect(serverTime, isNotNull);
      expect(serverTime!.epochSeconds, isNotNull);
    });
  });

  group('Authorized REST Requests to Coinbase AT API Endpoints with options',
      skip: constants.ciSkip, () {
    test('Get a page of accounts with a configured timeout', () async {
      final page = await getAccountsPage(
          limit: 1,
          credential: constants.credentials,
          options: const CoinbaseHttpOptions(timeout: Duration(seconds: 30)));

      logger.info('Accounts Page: ${page.items}');

      expect(page.items, isNotEmpty);
    });
  });
}
