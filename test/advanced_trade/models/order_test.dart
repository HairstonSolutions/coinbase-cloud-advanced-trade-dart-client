import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order.dart';
import 'package:test/test.dart';

import '../../tools.dart';

void main() {
  group('Test Order Object Injection', () {
    String exampleOrderJsonFile = 'advanced_trade/models/examples/order.json';
    String? exampleOrderJson;
    String openOrderJsonFile = 'advanced_trade/models/examples/open-order.json';
    String? openOrderJson;
    String marketOrderJsonFile =
        'advanced_trade/models/examples/market-order.json';
    String? marketOrderJson;

    setUp(() async {
      exampleOrderJson = await getJsonFromFile(exampleOrderJsonFile);
      openOrderJson = await getJsonFromFile(openOrderJsonFile);
      marketOrderJson = await getJsonFromFile(marketOrderJsonFile);
    });

    test('Test Example Order JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleOrderJson!);
      Order? exampleOrder = Order.convertJson(jsonAsMap);

      print('Order Object: $exampleOrder');

      expect(exampleOrder.orderId, '0000-000000-000000');
      expect(exampleOrder.status, 'PENDING');
      expect(exampleOrder.settled, true);
    });

    test('Test Example Order JSON Import Object conversion order configuration',
        () {
      var jsonAsMap = jsonDecode(exampleOrderJson!);
      Order? exampleOrder = Order.convertJson(jsonAsMap);
      expect(exampleOrder.orderConfiguration?.marketIOC?.quoteSize, 10.00);
      expect(exampleOrder.orderConfiguration?.limitGTC?.limitPrice, 10000.00);
      expect(exampleOrder.orderConfiguration?.limitGTD?.quoteSize, 10.00);
      expect(
          exampleOrder.orderConfiguration?.stopLimitGTC?.stopPrice, 20000.00);
      expect(exampleOrder.orderConfiguration?.stopLimitGTD?.stopDirection,
          'UNKNOWN_STOP_DIRECTION');
    });

    test('Test Example Open Order JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(openOrderJson!);
      Order? openOrder = Order.convertJson(jsonAsMap);

      print('Open Order Object: $openOrder');

      expect(openOrder.orderId, '111111111-1111-1111-1111-11111');
      expect(openOrder.status, 'OPEN');
      expect(openOrder.orderType, 'LIMIT');
      expect(openOrder.timeInForce, 'GOOD_UNTIL_CANCELLED');
      expect(openOrder.settled, false);
      expect(openOrder.orderConfiguration?.limitGTC?.postOnly, false);
    });

    test('Test Example Market Order JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(marketOrderJson!);
      Order? marketOrder = Order.convertJson(jsonAsMap);

      print('Market Order Object: $marketOrder');

      expect(marketOrder.orderId, '22222222-2222-2222-2222-222222222');
      expect(marketOrder.orderType, 'MARKET');
      expect(marketOrder.status, 'FILLED');
      expect(marketOrder.timeInForce, 'IMMEDIATE_OR_CANCEL');
      expect(marketOrder.settled, true);
      expect(marketOrder.orderConfiguration?.marketIOC?.quoteSize, 25);
    });
  });
}
