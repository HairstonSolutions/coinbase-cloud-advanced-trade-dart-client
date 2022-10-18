import 'dart:convert';
import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/entities/orders/orders.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/order.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? checkEnvSandbox = envVars['COINBASE_SANDBOX'];
String? cbAccessKey = envVars['COINBASE_ACCESS_KEY'];
String? cbSecret = envVars['COINBASE_SECRET'];
String? cbPassphrase = envVars['COINBASE_PASSPHRASE'];
bool isSbx = checkEnvSandbox == 'true' ? true : false;
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials = Credential(cbAccessKey!, cbSecret!, cbPassphrase!);

void main() {
  group('Test Fills', skip: skip, () {
    setUp(() {});

    test('Authorized Get with body (orders)', () async {
      List<Order> orders = [];
      String requestPath = "/orders";
      Map<String, dynamic>? queryParameters = {"limit": "100", "status": "all"};

      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: credentials,
          isSandbox: true);

      if (response.statusCode == 200) {
        String data = response.body;
        var jsonResponse = jsonDecode(data);

        for (var jsonObject in jsonResponse) {
          orders.add(Order.convertJson(jsonObject));
          print('$jsonObject/n');
        }
      } else {
        var url = response.request?.url.toString();
        print('Request to URL $url failed.');
      }

      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url\n\n');

      print(orders);

      expect(response.statusCode == 200, isTrue);
      expect(orders.isNotEmpty, isTrue);
    });

    test('Get all Orders', () async {
      List<Order> orders = await getOrders(
        credential: credentials,
        isSandbox: true,
      );

      print('Orders: $orders');

      expect(orders.isNotEmpty, true);
    });

    test('Get 10 of the latest Orders', () async {
      int limit = 10;
      List<Order> orders = await getOrders(
        limit: limit,
        credential: credentials,
        isSandbox: true,
      );

      print('$limit Orders: $orders');

      expect(orders.isNotEmpty, true);
      expect(orders.length <= limit, true);
    });
  });
}
