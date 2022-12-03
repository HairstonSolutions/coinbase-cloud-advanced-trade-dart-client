import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/order.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/rest/orders/orders.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? cbApiKey = envVars['COINBASE_API_KEY'];
String? cbApiSecret = envVars['COINBASE_API_SECRET'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials = Credential(cbApiKey!, cbApiSecret!);

void main() {
  group('Test Get Orders Requests to Coinbase AT API Endpoints', skip: skip,
      () {
    test('Authorized Get All Orders', () async {
      String requestPath = '/orders/historical/batch';
      Map<String, dynamic>? queryParameters = {'limit': '100'};
      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: credentials,
          isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
      expect(true, isTrue);
    });

    test('Get all Orders as a list of Orders', () async {
      List<Order>? orders =
          await getOrders(credential: credentials, isSandbox: true);
      print('Orders: $orders');

      expect(orders.isNotEmpty, true);
    });
  });

  group('Test Individual Orders', skip: skip, () {
    test('Get Individual Order', () async {
      List<Order> orders =
          await getOrders(credential: credentials, isSandbox: true);
      String? orderId = orders.first.orderId;
      Order? order = await getOrder(
        orderId: orderId!,
        credential: credentials,
        isSandbox: true,
      );

      expect(order?.orderId, orderId);
    });

    test('Individual Order Does Not Exist', () async {
      String orderId = 'b0313b63ee8d';
      Order? order = await getOrder(
        orderId: orderId,
        credential: credentials,
        isSandbox: true,
      );

      expect(order, null);
    });
  });
}
