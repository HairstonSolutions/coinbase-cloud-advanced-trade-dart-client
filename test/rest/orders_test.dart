import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/orders.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_constants.dart';
import '../tools.dart';
import 'orders_test.mocks.dart';

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);

@GenerateMocks([http.Client])
void main() {
  group('Orders REST Tests', () {
    test('Create Order', () async {
      final client = MockClient();
      final String createOrderJson =
          await getJsonFromFile('test/rest/orders/create_order.json');

      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(createOrderJson, 200));

      final result = await createOrder(
          client: client,
          credential: credentials,
          productId: 'BTC-USD',
          side: 'BUY',
          orderConfiguration: {
            'market_market_ioc': {
              'quote_size': '1000',
            }
          });

      expect(result, isNotNull);
      expect(result!.success, isTrue);
    });

    test('Cancel Orders', () async {
      final client = MockClient();
      final String cancelOrdersJson =
          await getJsonFromFile('test/rest/orders/cancel_orders.json');

      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(cancelOrdersJson, 200));

      final result = await cancelOrders(
          client: client, credential: credentials, orderIds: ['1234']);

      expect(result, isNotNull);
      expect(result!.results, isNotNull);
      expect(result.results!.isNotEmpty, isTrue);
    });

    test('List Orders', () async {
      final client = MockClient();
      final String listOrdersJson =
          await getJsonFromFile('test/rest/orders/list_orders.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(listOrdersJson, 200));

      final result = await getOrders(client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result.isNotEmpty, isTrue);
    });

    test('List Fills', () async {
      final client = MockClient();
      final String listFillsJson =
          await getJsonFromFile('test/rest/orders/list_fills.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(listFillsJson, 200));

      final result = await getFills(client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result.isNotEmpty, isTrue);
    });

    test('Get Order', () async {
      final client = MockClient();
      final String getOrderJson =
          await getJsonFromFile('test/rest/orders/get_order.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(getOrderJson, 200));

      final result = await getOrder(
          client: client, credential: credentials, orderId: '1234');

      expect(result, isNotNull);
      expect(result!.orderId, isNotNull);
    });
  });
}
