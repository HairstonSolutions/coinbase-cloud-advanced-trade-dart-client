import 'package:coinbase_cloud_advanced_trade_client/src/models/fill.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/orders/fills.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/orders/orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

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

      List<Fill>? fills =
          await getFills(client: mockClient, credential: constants.credentials);

      expect(fills, isNotNull);
      expect(fills.length, 1);
      expect(fills[0].orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
    });

    test('Get a single page of fills', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_fills.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      var page = await getFillsPage(
          client: mockClient, credential: constants.credentials);

      expect(page, isNotNull);
      expect(page.items.length, 1);
      expect(page.hasNext, false);
      expect(page.nextCursor, "");
      expect(page.items[0].orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
    });
    test('Get fills follows the cursor when has_next is absent', () async {
      final String mockResponsePage1 =
          await getJsonFromFile('rest/orders/get_fills_page_1.json');
      final String mockResponsePage2 =
          await getJsonFromFile('rest/orders/get_fills_page_2.json');

      var callCount = 0;
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        callCount++;
        return http.Response(
            callCount == 1 ? mockResponsePage1 : mockResponsePage2, 200);
      });

      List<Fill> fills =
          await getFills(client: mockClient, credential: constants.credentials);

      // List Fills does not document has_next, so the cursor alone drives the
      // loop for fills.
      expect(fills.length, 2);
      expect(fills[0].orderId, "fill-order-1");
      expect(fills[1].orderId, "fill-order-2");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(2);
    });

    test('Get fills stops when a page repeats the cursor it was given',
        () async {
      final String mockResponsePage1 =
          await getJsonFromFile('rest/orders/get_fills_page_1.json');
      final String mockResponsePage2 = await getJsonFromFile(
          'rest/orders/get_fills_page_2_repeat_cursor.json');

      var callCount = 0;
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        callCount++;
        return http.Response(
            callCount == 1 ? mockResponsePage1 : mockResponsePage2, 200);
      });

      List<Fill> fills =
          await getFills(client: mockClient, credential: constants.credentials);

      // Page 2 hands back the same cursor it was asked for, so following it
      // would replay the identical request forever.
      expect(fills.length, 2);
      expect(fills[1].orderId, "fill-order-3");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(2);
    });

    test('Get fills with array query parameters', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_fills.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((Invocation invocation) async {
        Uri url = invocation.positionalArguments[0] as Uri;
        expect(url.queryParametersAll['order_ids'], ['order1', 'order2']);
        expect(url.queryParametersAll['product_ids'], ['BTC-USD']);
        expect(url.queryParametersAll['start_sequence_timestamp'], ['1000']);
        return http.Response(mockResponse, 200);
      });

      List<Fill>? fills = await getFills(
          orderIds: ['order1', 'order2'],
          productIds: ['BTC-USD'],
          startSequenceTimestamp: '1000',
          client: mockClient,
          credential: constants.credentials);

      expect(fills, isNotNull);
    });

    test('Get fills merges the deprecated orderId and productId filters',
        () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_fills.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((Invocation invocation) async {
        Uri url = invocation.positionalArguments[0] as Uri;
        expect(url.queryParametersAll['order_ids'], ['order1', 'order2']);
        expect(url.queryParametersAll['product_ids'], ['BTC-USD', 'ETH-USD']);
        return http.Response(mockResponse, 200);
      });

      List<Fill>? fills = await getFills(
          // ignore: deprecated_member_use_from_same_package
          orderId: 'order1',
          orderIds: ['order2'],
          // ignore: deprecated_member_use_from_same_package
          productId: 'BTC-USD',
          productIds: ['ETH-USD'],
          client: mockClient,
          credential: constants.credentials);

      expect(fills, isNotNull);
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
    });
  });

  group('Test Get Fills Requests to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    test('Authorized Get All Fills', () async {
      String requestPath = '/orders/historical/fills';
      Map<String, dynamic>? queryParameters = {'limit': '1000'};
      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: constants.credentials,
          isSandbox: false);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
      expect(true, isTrue);
    });

    test('Get all Fills as a list of Fills', () async {
      List<Fill>? fills =
          await getFills(credential: constants.credentials, isSandbox: false);
      logger.info('Fills: $fills');

      expect(fills.isNotEmpty, true);
    });

    test('Get all Fills by order ID', () async {
      List<Order>? orders =
          await getOrders(credential: constants.credentials, isSandbox: false);
      String? orderId = orders.last.orderId;
      List<Fill>? fills = await getFills(
          orderIds: orderId != null ? [orderId] : null,
          credential: constants.credentials,
          isSandbox: false);
      logger.info('Fills: $fills');

      expect(fills.isNotEmpty, true);
      expect(fills.first.orderId, orderId);
    });

    test('Get all Fills by product ID', () async {
      List<Order>? orders =
          await getOrders(credential: constants.credentials, isSandbox: false);
      String? productId = orders.last.productId;
      List<Fill>? fills = await getFills(
          productIds: productId != null ? [productId] : null,
          credential: constants.credentials,
          isSandbox: false);
      logger.info('Fills: $fills');

      expect(fills.isNotEmpty, true);
      expect(fills.first.productId, productId);
    });
  });
}
