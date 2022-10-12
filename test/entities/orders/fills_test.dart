import 'dart:convert';
import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/entities/orders/fills.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/fill.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? checkEnvSandbox = envVars['COINBASE_SANDBOX'];
String? cbAccessKey = envVars['COINBASE_ACCESS_KEY'];
String? cbSecret = envVars['COINBASE_SECRET'];
String? cbPassphrase = envVars['COINBASE_PASSPHRASE'];
bool isSbx = checkEnvSandbox == 'true' ? true : false;
Credential credentials = Credential(cbAccessKey!, cbSecret!, cbPassphrase!);

void main() {
  group('Test Fills', skip: true, () {
    setUp(() {});

    test('Authorized Get with body (Fills)', () async {
      List<Fill> fills = [];
      String requestPath = "/fills";
      Map<String, dynamic>? queryParameters = {
        "profile_id": "default",
        "limit": "100",
        "product_id": "BTC-USD"
      };

      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: credentials,
          isSandbox: true);

      if (response.statusCode == 200) {
        String data = response.body;
        var jsonResponse = jsonDecode(data);

        for (var jsonObject in jsonResponse) {
          fills.add(Fill.convertJson(jsonObject));
        }
      } else {
        var url = response.request?.url.toString();
        print('Request to URL $url failed.');
      }

      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url\n\n');

      expect(response.statusCode == 200, isTrue);
      expect(fills.isNotEmpty, isTrue);
    });

    test('Get all Fills for ETH-BTC', () async {
      String productId = 'ETH-BTC';
      List<Fill> fills = await getFills(
          productId: productId, credential: credentials, isSandbox: true);
      print('Fills for product ID, $productId: $fills\n\n');
      expect(fills.isNotEmpty, true);
    });

    test('Get all Fills for BTC-USD limit 20', () async {
      String productId = 'BTC-USD';
      int limit = 20;
      List<Fill> fills = await getFills(
          productId: productId,
          limit: limit,
          credential: credentials,
          isSandbox: true);
      print('$limit Fills for product ID, $productId: $fills\n\n');
      expect(fills.isNotEmpty, true);
    });
  });

  group('Test for Fills by Order ID', skip: true, () {
    test('My Test', () async {
      String orderId = "f2f954f4-e257-4aab-a3ac-3b2f2faa1e43";
      List<Fill> fills = await getFillsByOrderId(orderId,
          credential: credentials, isSandbox: true);
      print('Fills for OrderID, $orderId: $fills');
      expect(fills.isNotEmpty, true);
    });
  });
}
