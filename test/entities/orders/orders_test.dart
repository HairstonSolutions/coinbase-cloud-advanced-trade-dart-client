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
  group('Test Orders', skip: skip, () {
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

  group('Test Individual Orders', skip: skip, () {
    test('Get Individual Order', () async {
      String orderId = '23290936-4561-4724-8502-b0313b63ee8d';
      Order? order = await getOrder(
        orderId: orderId,
        credential: credentials,
        isSandbox: true,
      );

      expect(order?.id == orderId, true);
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

    test('Get Individual Order by client order ID', () async {
      String clientOrderId = '66f3b900-7849-42ef-8c5d-2662dd389ca6';
      Order? order = await getOrderByClientOid(
        clientOid: clientOrderId,
        credential: credentials,
        isSandbox: true,
      );

      expect(order?.clientOid == clientOrderId, true);
    });
  });

  group('Create Orders', skip: skip, () {
    test('Create Limit order for 1 Bitcoin', () async {
      String side = 'buy';
      String productId = 'BTC-USD';
      String profileId = 'default';
      String type = 'limit';
      String timeInForce = 'GTC';
      num size = 1;
      num price = 300.00;
      String stp = 'dc';
      String cancelAfter = 'hour';
      bool postOnly = true;

      Order? createdOrder = await createOrder(
          side: side,
          productId: productId,
          profileId: profileId,
          type: type,
          size: size,
          price: price,
          timeInForce: timeInForce,
          stp: stp,
          cancelAfter: cancelAfter,
          postOnly: postOnly,
          credential: credentials,
          isSandbox: true);

      print(createdOrder);
      expect(createdOrder != null, true);
    });
  });
}
