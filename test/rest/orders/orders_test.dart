import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/preview_order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/stop_direction.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

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
        side: OrderSide.buy,
        quoteSize: '10',
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });

    test('Create a new stop limit GTC order (integration)',
        skip: constants.skipDT, () async {
      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createStopLimitOrderGTC(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: OrderSide.buy,
        baseSize: '0.00001',
        limitPrice: '100008',
        stopPrice: '100009',
        stopDirection: StopDirection.stopDirectionStopUp,
        credential: constants.credentials,
        isSandbox:
            false, // Sandbox API doesnt respond like the production version. Set to Prod for a true integration test.
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);

      // Cancel order after test
      final successResponse = result['success_response'];
      final orderId = successResponse['order_id'];

      final cancelResult = await cancelOrders(
          orderIds: [orderId], credential: constants.credentials);
      expect(cancelResult, isNotNull);
      expect(cancelResult!.canceledOrderResults![0].success, isTrue);
    });

    test('Create a new stop limit GTD order (integration)',
        skip: constants.skipDT, () async {
      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createStopLimitOrderGTD(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: OrderSide.buy,
        baseSize: '0.00001',
        limitPrice: '100004',
        stopPrice: '100005',
        stopDirection: StopDirection.stopDirectionStopUp,
        endTime: DateTime.now().add(const Duration(days: 1)),
        credential: constants.credentials,
        isSandbox:
            false, // Sandbox API doesnt respond like the production version. Set to Prod for a true integration test.
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);

      // Cancel order after test
      final successResponse = result['success_response'];
      final orderId = successResponse['order_id'];

      final cancelResult = await cancelOrders(
          orderIds: [orderId], credential: constants.credentials);
      expect(cancelResult, isNotNull);
      expect(cancelResult!.canceledOrderResults![0].success, isTrue);
    });

    test('Create a new stop limit GTC order (mocked)', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/create_order_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createStopLimitOrderGTC(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: OrderSide.buy,
        baseSize: '0.1',
        limitPrice: '10000',
        stopPrice: '10001',
        stopDirection: StopDirection.stopDirectionStopUp,
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });

    test('Create a new stop limit GTD order (mocked)', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/create_order_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createStopLimitOrderGTD(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: OrderSide.buy,
        baseSize: '0.1',
        limitPrice: '10000',
        stopPrice: '10001',
        stopDirection: StopDirection.stopDirectionStopUp,
        endTime: DateTime.now().add(const Duration(days: 1)),
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
        side: OrderSide.sell,
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
                side: OrderSide.buy,
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
        side: OrderSide.buy,
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
        side: OrderSide.buy,
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
        side: OrderSide.buy,
        quoteSize: '10',
        credential: constants.credentials,
        isSandbox: true,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });
  });

  group('Test Close Position using MockClients', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Close a position', () async {
      final String mockResponse = await getJsonFromFile(
          'mocks/rest/orders/close_position_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await closePosition(
        productId: 'BTC-USD',
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });
  });

  group('Test Close Position to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    test('Close a position', () async {
      final result = await closePosition(
        productId: 'BTC-USD',
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
        side: OrderSide.sell,
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
                side: OrderSide.buy,
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
        side: OrderSide.buy,
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
        side: OrderSide.buy,
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

  group('Test Cancel Orders using MockClients', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Cancel orders', () async {
      final String mockResponse =
          await getJsonFromFile('mocks/rest/orders/cancel_orders_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await cancelOrders(
        orderIds: ['8b9b69b3-5779-4673-8022-446777176512'],
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!.canceledOrderResults![0].success, isTrue);
    });
  });

  group('Test Cancel Orders to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    test('Cancel orders', () async {
      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createLimitOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: OrderSide.buy,
        baseSize: '0.001',
        limitPrice: '10000',
        postOnly: true,
        credential: constants.credentials,
        isSandbox: true,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);

      final successResponse = result['success_response'];
      final orderId = successResponse['order_id'];

      final cancelResult = await cancelOrders(
        orderIds: [orderId],
        credential: constants.credentials,
        isSandbox: true,
      );

      expect(cancelResult, isNotNull);
      expect(cancelResult!.canceledOrderResults![0].success, isTrue);
    });

    test('Cancel multiple orders', skip: constants.skipDT, () async {
      // Get current price og bitcoin in USD
      Ticker? bitcoinTicker =
          await getMarketTrades(productId: 'BTC-USD', limit: 1);
      final bitcoinPrice = bitcoinTicker?.trades?.first.price;

      // Set Prices of both Orders
      final orderPrice = bitcoinPrice! * 0.5;
      final secondOrderPrice = orderPrice - 1.0;

      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createLimitOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: OrderSide.buy,
        baseSize: '0.0001',
        limitPrice: orderPrice.toString(),
        postOnly: true,
        credential: constants.credentials,
      );

      expect(result, isNotNull);
      if (result!['success'] == false) {
        var errorResponse = result['error_response'];
        var failureReason = errorResponse['preview_failure_reason'];
        logger.info('failure Reason: $failureReason');
      }

      expect(result['success'], isTrue);

      final successResponse = result['success_response'];
      final orderId1 = successResponse['order_id'];

      final clientOrderId2 = DateTime.now().millisecondsSinceEpoch.toString();
      final result2 = await createLimitOrder(
        clientOrderId: clientOrderId2,
        productId: 'BTC-USD',
        side: OrderSide.buy,
        baseSize: '0.0001',
        limitPrice: secondOrderPrice.toString(),
        postOnly: true,
        credential: constants.credentials,
      );

      expect(result2, isNotNull);
      expect(result2!['success'], isTrue);

      final successResponse2 = result2['success_response'];
      final orderId2 = successResponse2['order_id'];

      final cancelResult = await cancelOrders(
        orderIds: [orderId1, orderId2],
        credential: constants.credentials,
      );

      expect(cancelResult, isNotNull);
      expect(cancelResult!.canceledOrderResults![0].success, isTrue);
      expect(cancelResult.canceledOrderResults![1].success, isTrue);
    });
  });

  group('Preview Order', () {
    test('previews a market order', () async {
      final mockClient = MockClient();
      final successResponse =
          await getJsonFromFile('mocks/rest/orders/preview_order_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(successResponse, 200));

      final PreviewOrderResponse previewOrderResponse = await previewOrder(
          client: mockClient,
          credential: constants.credentials,
          productId: 'BTC-USD',
          side: OrderSide.buy,
          orderConfiguration: {
            'market_market_ioc': {'quote_size': '10.0'}
          });

      expect(previewOrderResponse, isNotNull);
      expect(previewOrderResponse.orderTotal, '10.00');
      expect(previewOrderResponse.commissionTotal, '0.05');
      expect(previewOrderResponse.quoteSize, 10.00);
      expect(previewOrderResponse.baseSize, 0.001);
      expect(previewOrderResponse.bestBid, '9999.00');
      expect(previewOrderResponse.bestAsk, '10001.00');
      expect(previewOrderResponse.previewId, 'PREVIEW-ID-12345');
    });
  });

  group('Preview Order Integration', () {
    test('previews a market order', () async {
      final PreviewOrderResponse previewOrderResponse = await previewOrder(
          credential: constants.credentials,
          productId: 'BTC-USD',
          side: OrderSide.buy,
          orderConfiguration: {
            'market_market_ioc': {'quote_size': '2.0'}
          });

      logger.info('Preview Order Response: ${previewOrderResponse.toString()}');

      expect(previewOrderResponse, isNotNull);
      expect(previewOrderResponse.orderTotal, isNotNull);
    }, skip: constants.ciSkip);
  });
}
