import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/orders/orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('orders_test');

  group('Test Get Orders using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of orders', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_orders.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      List<Order>? orders = await getOrders(
          client: mockClient, credential: constants.credentials);

      expect(orders, isNotNull);
      expect(orders.length, 1);
      expect(orders[0].orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
    });

    test('Get a single order by ID', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_order.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      Order? order = await getOrder(
          orderId: "b0313b63-a2a1-4d30-a506-936337b52978",
          client: mockClient,
          credential: constants.credentials);

      expect(order, isNotNull);
      expect(order?.orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
    });

    test('Get a single order by a specific ID', () async {
      final specificOrderId = 'b0313b63-a2a1-4d30-a506-936337b52978';
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_order.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      Order? order = await getOrder(
          orderId: specificOrderId,
          client: mockClient,
          credential: constants.credentials);

      expect(order, isNotNull);
      expect(order?.orderId, specificOrderId);
    });

    test('Get a single order by a specific ID and Its not found', () async {
      final specificOrderId = 'a-specific-order';
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_order_not_found.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 404));

      expect(
          () async => await getOrder(
              orderId: specificOrderId,
              client: mockClient,
              credential: constants.credentials),
          throwsA(isA<CoinbaseException>()));
    });

    test('Return null when order not found', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_order_null.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 404));

      expect(
          () async => await getOrder(
              orderId: "non-existent-id",
              client: mockClient,
              credential: constants.credentials),
          throwsA(isA<CoinbaseException>()));
    });
  });

  group('Test Get Orders Requests to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    test('Authorized Get All Orders', () async {
      String requestPath = '/orders/historical/batch';
      Map<String, dynamic>? queryParameters = {'limit': '100'};
      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: constants.credentials,
          isSandbox: false);
      var url = response.request?.url.toString();
      logger.info(
          'Response Code: ${response.statusCode} to URL: $url with query parameters: $queryParameters');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
      expect(true, isTrue);
    });

    test('Get all Orders as a list of Orders', () async {
      List<Order>? orders =
          await getOrders(credential: constants.credentials, isSandbox: false);
      logger.info('Orders: $orders');

      expect(orders.isNotEmpty, true);
    });
  });

  group('Test Individual Orders', skip: constants.ciSkip, () {
    test('Get Individual Order', () async {
      List<Order> orders =
          await getOrders(credential: constants.credentials, isSandbox: false);
      String? orderId = orders.first.orderId;
      Order? order = await getOrder(
        orderId: orderId!,
        credential: constants.credentials,
        isSandbox: false,
      );

      expect(order?.orderId, orderId);
    });

    test('Individual Order Does Not Exist', () async {
      String orderId = 'b0313b63ee8d';
      expect(
          () async => await getOrder(
                orderId: orderId,
                credential: constants.credentials,
                isSandbox: false,
              ),
          throwsA(isA<CoinbaseException>()));
    });
  });

  group('Test Create Orders using MockClients', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Create a new market order with quote size', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/create_order_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createMarketOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'BUY',
        quoteSize: '10',
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });

    test('Create a new market order with base size', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/create_order_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createMarketOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'SELL',
        baseSize: '0.1',
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });

    test('Create a new market order with both quote and base size', () async {
      expect(
          () async => await createMarketOrder(
                clientOrderId: 'test',
                productId: 'BTC-USD',
                side: 'BUY',
                quoteSize: '10',
                baseSize: '0.1',
                credential: constants.credentials,
              ),
          throwsArgumentError);
    });

    test('Create a new limit order', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/create_order_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createLimitOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'BUY',
        baseSize: '0.1',
        limitPrice: '10000',
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });

    test('Create a new post-only limit order', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/create_order_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createLimitOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'BUY',
        baseSize: '0.1',
        limitPrice: '10000',
        postOnly: true,
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });
  });

  group('Test Create Orders to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    test('Create a new market order with quote size', () async {
      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createMarketOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'BUY',
        quoteSize: '10',
        credential: constants.credentials,
        isSandbox: true,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });

    test('Create a new market order with base size', () async {
      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createMarketOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'SELL',
        baseSize: '0.1',
        credential: constants.credentials,
        isSandbox: true,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });

    test('Create a new market order with both quote and base size', () async {
      expect(
          () async => await createMarketOrder(
                clientOrderId: 'test',
                productId: 'BTC-USD',
                side: 'BUY',
                quoteSize: '10',
                baseSize: '0.1',
                credential: constants.credentials,
                isSandbox: true,
              ),
          throwsArgumentError);
    });

    test('Create a new limit order', () async {
      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createLimitOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'BUY',
        baseSize: '0.1',
        limitPrice: '10000',
        credential: constants.credentials,
        isSandbox: true,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });

    test('Create a new post-only limit order', () async {
      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createLimitOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'BUY',
        baseSize: '0.001',
        limitPrice: '10000',
        postOnly: true,
        credential: constants.credentials,
        isSandbox: true,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });
  });
}
