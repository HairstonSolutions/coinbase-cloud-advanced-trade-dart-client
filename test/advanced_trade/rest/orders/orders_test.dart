import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/orders/orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'dart:convert';

Map<String, String> envVars = Platform.environment;
String? apiKeyName = envVars['COINBASE_API_KEY_NAME'];
String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials =
    Credential(apiKeyName: apiKeyName!, privateKeyPEM: privateKeyPEM!);

void main() {
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

  group('Test Create Order', () {
    test('Create a new order', () async {
      final mockClient = MockClient((request) async {
        final response = {
          "success": true,
          "failure_reason": "string",
          "order_id": "string"
        };
        return http.Response(json.encode(response), 200);
      });

      final clientOrderId = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await createOrder(
        clientOrderId: clientOrderId,
        productId: 'BTC-USD',
        side: 'BUY',
        orderConfiguration: {
          'market_market_ioc': {
            'quote_size': '10',
          }
        },
        credential: credentials,
        client: mockClient,
      );

      expect(result, isNotNull);
      expect(result!['success'], isTrue);
    });
  });
}
