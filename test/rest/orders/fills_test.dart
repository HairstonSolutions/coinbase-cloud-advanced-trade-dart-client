import 'dart:convert';
import 'dart:io' show Platform;
import 'package:logging/logging.dart';
import '../../test_helpers.dart';
import '../../test_constants.dart' as testConstants;
import '../../tools.dart';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/fill.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/orders/fills.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/orders/orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fills_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('fills_test');

  group('Test Get Fills using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of fills', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_fills.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      List<Fill>? fills = await getFills(
          client: mockClient, credential: testConstants.credentials);

      expect(fills, isNotNull);
      expect(fills.length, 1);
      expect(fills[0].orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
    });
  });

  group('Test Get Fills Requests to Coinbase AT API Endpoints',
      skip: testConstants.ciSkip, () {
    test('Authorized Get All Fills', () async {
      String requestPath = '/orders/historical/fills';
      Map<String, dynamic>? queryParameters = {'limit': '1000'};
      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: testConstants.credentials,
          isSandbox: false);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
      expect(true, isTrue);
    });

    test('Get all Fills as a list of Fills', () async {
      List<Fill>? fills = await getFills(
          credential: testConstants.credentials, isSandbox: false);
      logger.info('Fills: $fills');

      expect(fills.isNotEmpty, true);
    });

    test('Get all Fills by order ID', () async {
      List<Order>? orders = await getOrders(
          credential: testConstants.credentials, isSandbox: false);
      String? orderId = orders.last.orderId;
      List<Fill>? fills = await getFills(
          orderId: orderId,
          credential: testConstants.credentials,
          isSandbox: false);
      logger.info('Fills: $fills');

      expect(fills.isNotEmpty, true);
      expect(fills.first.orderId, orderId);
    });

    test('Get all Fills by product ID', () async {
      List<Order>? orders = await getOrders(
          credential: testConstants.credentials, isSandbox: false);
      String? productId = orders.last.productId;
      List<Fill>? fills = await getFills(
          productId: productId,
          credential: testConstants.credentials,
          isSandbox: false);
      logger.info('Fills: $fills');

      expect(fills.isNotEmpty, true);
      expect(fills.first.productId, productId);
    });
  });
}
