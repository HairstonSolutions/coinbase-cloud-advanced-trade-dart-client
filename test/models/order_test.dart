import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_configuration.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_status.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_type.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/time_in_force.dart';
import 'package:test/test.dart';

import '../tools.dart';

void main() {
  group('Order Object Injection', () {
    String exampleOrderJsonFile = 'models/examples/order.json';
    String? exampleOrderJson;
    String exampleOrderJsonFile2 = 'models/examples/order2.json';
    String? exampleOrderJson2;
    String openOrderJsonFile = 'models/examples/open-order.json';
    String? openOrderJson;
    String marketOrderJsonFile = 'models/examples/market-order.json';
    String? marketOrderJson;

    setUp(() async {
      exampleOrderJson = await getJsonFromFile(exampleOrderJsonFile);
      exampleOrderJson2 = await getJsonFromFile(exampleOrderJsonFile2);
      openOrderJson = await getJsonFromFile(openOrderJsonFile);
      marketOrderJson = await getJsonFromFile(marketOrderJsonFile);
    });

    test('Example Order JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleOrderJson!);
      Order? exampleOrder = Order.fromCBJson(jsonAsMap);

      print('Order Object: $exampleOrder');

      expect(exampleOrder.orderId, '0000-000000-000000');
      expect(exampleOrder.status, OrderStatus.PENDING);
      expect(exampleOrder.settled, true);
    });

    test('Example Order JSON Import Object conversion order configuration', () {
      var jsonAsMap = jsonDecode(exampleOrderJson!);
      Order? exampleOrder = Order.fromCBJson(jsonAsMap);
      expect(exampleOrder.orderConfiguration?.marketIOC?.quoteSize, 10.00);
      expect(exampleOrder.orderConfiguration?.limitGTC?.limitPrice, 10000.00);
      expect(exampleOrder.orderConfiguration?.limitGTD?.quoteSize, 10.00);
      expect(
          exampleOrder.orderConfiguration?.stopLimitGTC?.stopPrice, 20000.00);
      expect(exampleOrder.orderConfiguration?.stopLimitGTD?.stopDirection,
          StopDirection.UNKNOWN_STOP_DIRECTION);
    });

    test('Example Open Order JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(openOrderJson!);
      Order? openOrder = Order.fromCBJson(jsonAsMap);

      print('Open Order Object: $openOrder');

      expect(openOrder.orderId, '111111111-1111-1111-1111-11111');
      expect(openOrder.status, OrderStatus.OPEN);
      expect(openOrder.orderType, OrderType.LIMIT);
      expect(openOrder.timeInForce, TimeInForce.GOOD_UNTIL_CANCELLED);
      expect(openOrder.settled, false);
      expect(openOrder.orderConfiguration?.limitGTC?.postOnly, false);
    });

    test('Example Market Order JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(marketOrderJson!);
      Order? marketOrder = Order.fromCBJson(jsonAsMap);

      print('Market Order Object: $marketOrder');

      expect(marketOrder.orderId, '22222222-2222-2222-2222-222222222');
      expect(marketOrder.orderType, OrderType.MARKET);
      expect(marketOrder.status, OrderStatus.FILLED);
      expect(marketOrder.timeInForce, TimeInForce.IMMEDIATE_OR_CANCEL);
      expect(marketOrder.settled, true);
      expect(marketOrder.orderConfiguration?.marketIOC?.quoteSize, 25);
    });

    test('Example Order JSON Import, Serialize, deserialize', () {
      var jsonAsMap = jsonDecode(exampleOrderJson!);
      Order? exampleOrder = Order.fromCBJson(jsonAsMap);
      var serializedOrder = exampleOrder.toJson();

      Order? deserializedOrder = Order.fromJson(serializedOrder);

      print('Deserialized Order Object: $deserializedOrder');
      print(jsonEncode(deserializedOrder));

      expect(deserializedOrder.orderConfiguration?.marketIOC?.quoteSize, 10.00);
      expect(
          deserializedOrder.orderConfiguration?.limitGTC?.limitPrice, 10000.00);
      expect(deserializedOrder.orderConfiguration?.limitGTD?.quoteSize, 10.00);
      expect(deserializedOrder.orderConfiguration?.stopLimitGTC?.stopPrice,
          20000.00);
      expect(deserializedOrder.orderConfiguration?.stopLimitGTD?.stopDirection,
          StopDirection.UNKNOWN_STOP_DIRECTION);

      print(deserializedOrder.orderConfiguration);
      print(deserializedOrder.orderConfiguration?.toJson());
      print(deserializedOrder.orderConfiguration?.toCBJson());
      print(jsonEncode(deserializedOrder.orderConfiguration?.toCBJson()));
    });

    test('Example Order JSON Import, Serialize, II', () {
      var jsonAsMap = jsonDecode(exampleOrderJson2!);
      Order? exampleOrder = Order.fromCBJson(jsonAsMap);
      var serializedOrder = exampleOrder.toJson();

      Order? deserializedOrder = Order.fromJson(serializedOrder);

      print('Deserialized Order as CB Map: ${deserializedOrder.toCBJson()}');
      print(
          'Deserialized Order as CB JSON: ${jsonEncode(deserializedOrder.toCBJson())}');
      print(deserializedOrder.orderConfiguration);
      print(jsonEncode(deserializedOrder.orderConfiguration?.toCBJson()));

      expect(deserializedOrder.orderConfiguration?.marketIOC?.quoteSize, 10.00);
      expect(deserializedOrder.orderConfiguration?.limitGTC, null);
      expect(deserializedOrder.orderConfiguration?.limitGTD, null);
      expect(deserializedOrder.orderConfiguration?.stopLimitGTC, null);
      expect(deserializedOrder.orderConfiguration?.stopLimitGTD, null);
    });
  });
}
