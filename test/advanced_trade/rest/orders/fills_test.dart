import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/fill.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/orders/fills.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/orders/orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? apiKeyName = envVars['COINBASE_API_KEY_NAME'];
String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials =
    Credential(apiKeyName: apiKeyName!, privateKeyPEM: privateKeyPEM!);

void main() {
  group('Test Get Fills Requests to Coinbase AT API Endpoints', skip: skip, () {
    test('Authorized Get All Fills', () async {
      String requestPath = '/orders/historical/fills';
      Map<String, dynamic>? queryParameters = {'limit': '1000'};
      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: credentials,
          isSandbox: false);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
      expect(true, isTrue);
    });

    test('Get all Fills as a list of Fills', () async {
      List<Fill>? fills =
          await getFills(credential: credentials, isSandbox: false);
      print('Fills: $fills');

      expect(fills.isNotEmpty, true);
    });

    test('Get all Fills by order ID', () async {
      List<Order>? orders =
          await getOrders(credential: credentials, isSandbox: false);
      String? orderId = orders.last.orderId;
      List<Fill>? fills = await getFills(
          orderId: orderId, credential: credentials, isSandbox: false);
      print('Fills: $fills');

      expect(fills.isNotEmpty, true);
      expect(fills.first.orderId, orderId);
    });

    test('Get all Fills by product ID', () async {
      List<Order>? orders =
          await getOrders(credential: credentials, isSandbox: false);
      String? productId = orders.last.productId;
      List<Fill>? fills = await getFills(
          productId: productId, credential: credentials, isSandbox: false);
      print('Fills: $fills');

      expect(fills.isNotEmpty, true);
      expect(fills.first.productId, productId);
    });
  });
}
