import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/fill.dart';
import 'package:test/test.dart';

import '../../tools.dart';

void main() {
  group('Test Fill Object Injection', () {
    String exampleFillJsonFile = 'advanced_trade/models/examples/fill.json';
    String? exampleFillJson;
    String microFillJsonFile =
        'advanced_trade/models/examples/micro-fills.json';
    String? microFillJson;

    setUp(() async {
      exampleFillJson = await getJsonFromFile(exampleFillJsonFile);
      microFillJson = await getJsonFromFile(microFillJsonFile);
    });

    test('Example Fill JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleFillJson!);
      Fill? exampleFill = Fill.fromCBJson(jsonAsMap);

      print('Fill Object: $exampleFill');

      expect(exampleFill.entryId, '22222-2222222-22222222');
      expect(exampleFill.orderId, '0000-000000-000000');
      expect(exampleFill.tradeTime, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleFill.tradeType, 'FILL');
      expect(exampleFill.price, 10000.00);
      expect(exampleFill.size, 0.001);
      expect(exampleFill.commission, 1.25);
      expect(exampleFill.productId, 'BTC-USD');
      expect(exampleFill.sizeInQuote, false);
    });

    test('Example Fill JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(microFillJson!);
      Fill? exampleFill = Fill.fromCBJson(jsonAsMap);

      print('Fill Object: $exampleFill');

      expect(exampleFill.entryId, '22222-2222222-22222222');
      expect(exampleFill.orderId, '0000-000000-000000');
      expect(exampleFill.tradeTime, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleFill.tradeType, 'FILL');
      expect(exampleFill.price, 10000.00);
      expect(exampleFill.size, 0.00000001);
      expect(exampleFill.commission, 0.0000000028064);
      expect(exampleFill.productId, 'BTC-USD');
      expect(exampleFill.sizeInQuote, false);
    });

    test('Example Fill JSON Import, Serialize, deserialize', () {
      var jsonAsMap = jsonDecode(microFillJson!);
      Fill? exampleFill = Fill.fromCBJson(jsonAsMap);
      var serializedFill = exampleFill.toJson();

      Fill? deserializedFill = Fill.fromJson(serializedFill);
      print('Deserialized Fill Object: $deserializedFill');
      print(jsonEncode(deserializedFill));
    });
  });
}
