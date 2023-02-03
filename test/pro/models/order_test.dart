import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/pro/models/order.dart';
import 'package:test/test.dart';

import '../../tools.dart';

void main() {
  group('Test Order Object Injection', () {
    String exampleOrderJsonFile = 'pro/models/examples/order.json';
    String? exampleOrderJson;
    String openOrderJsonFile = 'pro/models/examples/open-order.json';
    String? openOrderJson;

    setUp(() async {
      exampleOrderJson = await getJsonFromFile(exampleOrderJsonFile);
      openOrderJson = await getJsonFromFile(openOrderJsonFile);
    });

    test('Test Example Order JSON Import Object conversion', () {
      var cbJsonAsMap = jsonDecode(exampleOrderJson!);
      Order? exampleOrder = Order.fromCBJson(cbJsonAsMap);

      print('Order Object: $exampleOrder');

      expect(exampleOrder.id, '927700a7-8bb0-4d1b-97b0-05f1f6f75732');
      expect(exampleOrder.status, 'done');
      expect(exampleOrder.settled, true);
    });

    test('Test Example Open Order JSON Import Object conversion', () {
      var cbJsonAsMap = jsonDecode(openOrderJson!);
      Order? openOrder = Order.fromCBJson(cbJsonAsMap);

      print('Open Order Object: $openOrder');

      expect(openOrder.id, 'a9625b04-fc66-4999-a876-543c3684d702');
      expect(openOrder.status, 'open');
      expect(openOrder.type, 'limit');
      expect(openOrder.timeInForce, 'GTC');
      expect(openOrder.settled, false);
      expect(openOrder.postOnly, true);
    });

    test('Example Open Order JSON Import, Serialize, deserialize', () {
      var cbJsonAsMap = jsonDecode(openOrderJson!);
      Order? openOrder = Order.fromCBJson(cbJsonAsMap);
      var serializedOrder = openOrder.toJson();

      Order? deserializedOrder = Order.fromJson(serializedOrder);

      print('Deserialized Order Object: $deserializedOrder');

      expect(deserializedOrder.id, 'a9625b04-fc66-4999-a876-543c3684d702');
      expect(deserializedOrder.status, 'open');
      expect(deserializedOrder.type, 'limit');
      expect(deserializedOrder.timeInForce, 'GTC');
      expect(deserializedOrder.settled, false);
      expect(deserializedOrder.postOnly, true);

      print('Serialized Order: ${jsonEncode(openOrder).toString()}');
    });
  });
}
