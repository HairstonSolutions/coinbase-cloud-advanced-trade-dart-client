import 'dart:convert';
import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/orders/orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../mocks.mocks.dart';

Map<String, String> envVars = Platform.environment;
String? apiKeyName = envVars['COINBASE_API_KEY_NAME'];
String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials =
    Credential(apiKeyName: apiKeyName!, privateKeyPEM: privateKeyPEM!);
Credential mockCredentials =
    Credential(apiKeyName: 'mock-key', privateKeyPEM: 'mock-pem');

void main() {
  group('Test Get Orders using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of orders', () async {
      final mockResponse = {
        "orders": [
          {
            "order_id": "b0313b63-a2a1-4d30-a506-936337b52978",
            "client_order_id": "292f7b0c-ca72-421b-bfce-a46ce5a76118",
            "product_id": "BTC-USD",
            "user_id": "584421a7-05c2-473d-9d48-9724f7e22137",
            "order_configuration": {
              "market_market_ioc": {
                "quote_size": "1000",
                "base_size": null,
              }
            },
            "side": "BUY",
            "status": "FILLED",
            "time_in_force": "IMMEDIATE_OR_CANCEL",
            "created_time": "2021-05-31T09:59:59Z",
            "completion_percentage": "100",
            "filled_size": "0.01",
            "average_filled_price": "50000",
            "fee": "0.50",
            "number_of_fills": "1",
            "filled_value": "500",
            "pending_cancel": false,
            "size_in_quote": false,
            "total_fees": "0.50",
            "size_inclusive_of_fees": false,
            "total_value_after_fees": "500.50",
            "trigger_status": "INVALID_ORDER_TYPE",
            "order_type": "MARKET",
            "reject_reason": "REJECT_REASON_UNSPECIFIED",
            "settled": true,
            "product_type": "SPOT",
            "reject_message": "",
            "cancel_message": ""
          }
        ],
        "has_next": false,
        "cursor": ""
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      List<Order>? orders =
          await getOrders(client: mockClient, credential: mockCredentials);

      expect(orders, isNotNull);
      expect(orders?.length, 1);
      expect(orders?[0].orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
    });

    test('Get a single order by ID', () async {
      final mockResponse = {
        "order": {
          "order_id": "b0313b63-a2a1-4d30-a506-936337b52978",
          "client_order_id": "292f7b0c-ca72-421b-bfce-a46ce5a76118",
          "product_id": "BTC-USD",
          "user_id": "584421a7-05c2-473d-9d48-9724f7e22137",
          "order_configuration": {
            "market_market_ioc": {
              "quote_size": "1000",
              "base_size": null,
            }
          },
          "side": "BUY",
          "status": "FILLED",
          "time_in_force": "IMMEDIATE_OR_CANCEL",
          "created_time": "2021-05-31T09:59:59Z",
          "completion_percentage": "100",
          "filled_size": "0.01",
          "average_filled_price": "50000",
          "fee": "0.50",
          "number_of_fills": "1",
          "filled_value": "500",
          "pending_cancel": false,
          "size_in_quote": false,
          "total_fees": "0.50",
          "size_inclusive_of_fees": false,
          "total_value_after_fees": "500.50",
          "trigger_status": "INVALID_ORDER_TYPE",
          "order_type": "MARKET",
          "reject_reason": "REJECT_REASON_UNSPECIFIED",
          "settled": true,
          "product_type": "SPOT",
          "reject_message": "",
          "cancel_message": ""
        }
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      Order? order = await getOrder(
          orderId: "b0313b63-a2a1-4d30-a506-936337b52978",
          client: mockClient,
          credential: mockCredentials);

      expect(order, isNotNull);
      expect(order?.orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
    });

    test('Return null when order not found', () async {
      final mockResponse = {"order": null};

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      Order? order = await getOrder(
          orderId: "non-existent-id",
          client: mockClient,
          credential: mockCredentials);
      expect(order, isNull);
    });
  });

  group('Test Get Orders Requests to Coinbase AT API Endpoints', skip: skip,
      () {
    test('Authorized Get All Orders', () async {
      String requestPath = '/orders/historical/batch';
      Map<String, dynamic>? queryParameters = {'limit': '100'};
      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: credentials,
          isSandbox: false);
      var url = response.request?.url.toString();
      print(
          'Response Code: ${response.statusCode} to URL: $url with query parameters: $queryParameters');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
      expect(true, isTrue);
    });

    test('Get all Orders as a list of Orders', () async {
      List<Order>? orders =
          await getOrders(credential: credentials, isSandbox: false);
      print('Orders: $orders');

      expect(orders.isNotEmpty, true);
    });
  });

  group('Test Individual Orders', skip: skip, () {
    test('Get Individual Order', () async {
      List<Order> orders =
          await getOrders(credential: credentials, isSandbox: false);
      String? orderId = orders.first.orderId;
      Order? order = await getOrder(
        orderId: orderId!,
        credential: credentials,
        isSandbox: false,
      );

      expect(order?.orderId, orderId);
    });

    test('Individual Order Does Not Exist', () async {
      String orderId = 'b0313b63ee8d';
      Order? order = await getOrder(
        orderId: orderId,
        credential: credentials,
        isSandbox: false,
      );

      expect(order, null);
    });
  });
}
