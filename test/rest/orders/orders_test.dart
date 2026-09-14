import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/create_order_result.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/preview_order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/stop_direction.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
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
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
    });

    test('Get a single page of orders', () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_orders_page_1.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      var page = await getOrdersPage(
          client: mockClient, credential: constants.credentials);

      expect(page, isNotNull);
      expect(page.items.length, 1);
      expect(page.hasNext, true);
      expect(page.nextCursor, "cursor-123");
      expect(page.items[0].orderId, "order-1");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
    });

    test('Get orders with pagination', () async {
      final String mockResponsePage1 =
          await getJsonFromFile('rest/orders/get_orders_page_1.json');
      final String mockResponsePage2 =
          await getJsonFromFile('rest/orders/get_orders_page_2.json');

      var callCount = 0;
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        if (callCount == 0) {
          callCount++;
          return http.Response(mockResponsePage1, 200);
        } else {
          return http.Response(mockResponsePage2, 200);
        }
      });

      List<Order>? orders = await getOrders(
          client: mockClient, credential: constants.credentials);

      expect(orders, isNotNull);
      expect(orders.length, 2);
      expect(orders[0].orderId, "order-1");
      expect(orders[1].orderId, "order-2");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(2);
    });

    test('Get orders with all filters correctly constructs query string',
        () async {
      final String mockResponse =
          await getJsonFromFile('rest/orders/get_orders.json');

      Uri? capturedUri;
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((Invocation invocation) async {
        capturedUri = invocation.positionalArguments.first as Uri;
        return http.Response(mockResponse, 200);
      });

      await getOrders(
          limit: 50,
          productIds: ['BTC-USD', 'ETH-USD'],
          orderStatus: ['OPEN', 'PENDING'],
          orderSide: 'BUY',
          orderType: 'LIMIT',
          orderPlacementSource: 'RETAIL_ADVANCED',
          contractExpiryType: 'EXPIRING',
          assetFilters: ['BTC', 'ETH'],
          timeInForces: ['GTC', 'IOC'],
          startDate: '2023-01-01T00:00:00Z',
          endDate: '2023-01-31T23:59:59Z',
          sortBy: 'LIMIT_PRICE',
          retailPortfolioId: 'portfolio-123',
          client: mockClient,
          credential: constants.credentials);

      expect(capturedUri, isNotNull);
      final queryParams = capturedUri!.queryParametersAll;

      expect(queryParams['limit'], ['50']);
      expect(queryParams['product_ids'], ['BTC-USD', 'ETH-USD']);
      expect(queryParams['order_status'], ['OPEN', 'PENDING']);
      expect(queryParams['order_side'], ['BUY']);
      expect(queryParams['order_types'], ['LIMIT']);
      expect(queryParams['order_placement_source'], ['RETAIL_ADVANCED']);
      expect(queryParams['contract_expiry_type'], ['EXPIRING']);
      expect(queryParams['asset_filters'], ['BTC', 'ETH']);
      expect(queryParams['time_in_forces'], ['GTC', 'IOC']);
      expect(queryParams['start_date'], ['2023-01-01T00:00:00Z']);
      expect(queryParams['end_date'], ['2023-01-31T23:59:59Z']);
      expect(queryParams['sort_by'], ['LIMIT_PRICE']);
      expect(queryParams['retail_portfolio_id'], ['portfolio-123']);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);

      // Cancel order after test
      final successResponse = result.raw['success_response'];
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);

      // Cancel order after test
      final successResponse = result.raw['success_response'];
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
    });

    test('closePosition does not log response body at INFO level', () async {
      Logger.root.level = Level.INFO;
      final List<LogRecord> logs = [];
      final subscription = Logger.root.onRecord.listen((record) {
        logs.add(record);
      });

      final String mockResponse = await getJsonFromFile(
          'mocks/rest/orders/close_position_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      await closePosition(
        productId: 'BTC-USD',
        credential: constants.credentials,
        client: mockClient,
      );

      await subscription.cancel();

      for (var log in logs) {
        // Assert no response body is in the info logs or above
        expect(log.message.contains('success_response'), isFalse);
      }
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);
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

      expect(result, isA<OrderSuccess>());
      expect((result as OrderSuccess).orderId, isNotEmpty);

      final successResponse = result.raw['success_response'];
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
      final orderPrice = bitcoinPrice! * Decimal.parse('0.5');
      final secondOrderPrice = orderPrice - Decimal.one;

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

      expect(result, isA<OrderSuccess>());
      if (result is OrderRejected) {
        var errorResponse = result.raw['error_response'];
        var failureReason = errorResponse['preview_failure_reason'];
        logger.info('failure Reason: $failureReason');
      }

      final successResponse = result.raw['success_response'];
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

      expect(result2, isA<OrderSuccess>());

      final successResponse2 = result2.raw['success_response'];
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
      expect(previewOrderResponse.quoteSize, Decimal.parse('10.00'));
      expect(previewOrderResponse.baseSize, Decimal.parse('0.001'));
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
      expect(previewOrderResponse.commissionTotal, isNotNull);
      expect(double.parse(previewOrderResponse.orderTotal!),
          greaterThanOrEqualTo(2.0));
    }, skip: constants.ciSkip);
    test('Create order rejected - Duplicate Client Order ID', () async {
      final String mockResponse = await getJsonFromFile(
          'rest/orders/create_order_rejected_duplicate.json');

      final mockClient = MockClient();
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

      expect(result, isA<OrderRejected>());
      final rejected = result as OrderRejected;
      expect(rejected.reason, OrderRejectReason.duplicateClientOrderId);
      expect(rejected.orderId, '1111-2222-3333-4444');
      expect(rejected.message, 'Duplicate client order id');
    });

    test('Create order rejected - Insufficient Funds', () async {
      final String mockResponse = await getJsonFromFile(
          'rest/orders/create_order_rejected_insufficient_funds.json');

      final mockClient = MockClient();
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

      expect(result, isA<OrderRejected>());
      final rejected = result as OrderRejected;
      expect(rejected.reason, OrderRejectReason.insufficientFunds);
      expect(rejected.message, 'Insufficient funds');
    });

    test('Create order rejected - Post Only', () async {
      final String mockResponse = await getJsonFromFile(
          'rest/orders/create_order_rejected_post_only.json');

      final mockClient = MockClient();
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

      expect(result, isA<OrderRejected>());
      final rejected = result as OrderRejected;
      expect(rejected.reason, OrderRejectReason.postOnlyWouldCross);
      expect(
          rejected.message, 'Post only limit order would cross the order book');
    });
  });
}
