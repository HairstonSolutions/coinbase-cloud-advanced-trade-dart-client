import 'dart:convert';

import 'package:coinbase_pro_sdk/src/models/fill.dart';
import 'package:test/test.dart';

import '../tools.dart';

void main() {
  group('Test Fill Object Injection', () {
    String exampleFillJsonFile = 'models/examples/fill.json';
    String? exampleFillJson;

    setUp(() async {
      exampleFillJson = await getJsonFromFile(exampleFillJsonFile);
    });

    test('Example Fill JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleFillJson!);
      Fill? exampleFill = Fill.fromCBJson(jsonAsMap);

      print('Fill Object: $exampleFill');

      expect(exampleFill.tradeId, 36916683);
      expect(
          exampleFill.createdAt, DateTime.parse('2021-12-24T17:01:00.300546Z'));
      expect(exampleFill.productId, 'BTC-USD');
      expect(exampleFill.orderId, '200d07ba-e12b-494b-9a97-07fb0a94a95f');
      expect(exampleFill.userId, '61b2242f9ad43702b15c816e');
      expect(exampleFill.profileId, 'c1173eaa-6451-4a0e-9c3a-334076c8a44d');
      expect(exampleFill.liquidity, 'M');
      expect(exampleFill.price, 99.98);
      expect(exampleFill.size, 8.0);
      expect(exampleFill.fee, 3.9992);
      expect(exampleFill.side, 'buy');
      expect(exampleFill.settled, true);
      expect(exampleFill.usdVolume, 799.84);
    });

    test('Example Fill JSON Import, Serialize, deserialize', () {
      var jsonAsMap = jsonDecode(exampleFillJson!);
      Fill? exampleFill = Fill.fromCBJson(jsonAsMap);
      var serializedFill = exampleFill.toJson();

      Fill? deserializedFill = Fill.fromJson(serializedFill);
      print('Deserialized Fill Object: $exampleFill');
      print('Json Encoded: ${jsonEncode(deserializedFill)}');

      expect(deserializedFill.tradeId, 36916683);
      expect(deserializedFill.createdAt,
          DateTime.parse('2021-12-24T17:01:00.300546Z'));
      expect(deserializedFill.productId, 'BTC-USD');
      expect(deserializedFill.orderId, '200d07ba-e12b-494b-9a97-07fb0a94a95f');
      expect(deserializedFill.userId, '61b2242f9ad43702b15c816e');
      expect(
          deserializedFill.profileId, 'c1173eaa-6451-4a0e-9c3a-334076c8a44d');
      expect(deserializedFill.liquidity, 'M');
      expect(deserializedFill.price, 99.98);
      expect(deserializedFill.size, 8.0);
      expect(deserializedFill.fee, 3.9992);
      expect(deserializedFill.side, 'buy');
      expect(deserializedFill.settled, true);
      expect(deserializedFill.usdVolume, 799.84);
    });
  });
}
