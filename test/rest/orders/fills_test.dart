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
