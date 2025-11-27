import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/trade.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../test_helpers.dart';
import '../tools.dart';

void main() {
  final Logger logger = setupLogger('trade_test');

  group('Test Trade Object Injection', () {
    String exampleTradeJsonFile = 'models/examples/trade.json';
    String? exampleTradeJson;

    setUp(() async {
      exampleTradeJson = await getJsonFromFile(exampleTradeJsonFile);
    });

    test('Example Trade JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleTradeJson!);
      Trade? exampleTrade = Trade.fromCBJson(jsonAsMap);

      logger.info('Trade Object: $exampleTrade');
      logger.info('Trade jsonEncoded Map: ${exampleTrade.toJson()}');
      logger.info('Trade CB jsonEncoded: ${exampleTrade.toCBJson()}');

      expect(exampleTrade.tradeId, '34b080bf-fcfd-445a-832b-46b5ddc65601');
      expect(exampleTrade.productId, 'BTC-USD');
      expect(exampleTrade.price, 140.91);
      expect(exampleTrade.size, 4);
      expect(exampleTrade.time, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleTrade.side, 'UNKNOWN_ORDER_SIDE');
      expect(exampleTrade.bid, 291.13);
      expect(exampleTrade.ask, 292.40);
    });

    test('Example Trade JSON Import, Serialize, deserialize', () {
      var jsonAsMap = jsonDecode(exampleTradeJson!);
      Trade? exampleTrade = Trade.fromCBJson(jsonAsMap);
      var serializedTrade = exampleTrade.toJson();

      Trade? deserializedTrade = Trade.fromJson(serializedTrade);
      logger.info('Deserialized Trade Object: $deserializedTrade');
      logger.info('Json Encoded: ${jsonEncode(deserializedTrade)}');

      expect(deserializedTrade.tradeId, '34b080bf-fcfd-445a-832b-46b5ddc65601');
      expect(deserializedTrade.productId, 'BTC-USD');
      expect(deserializedTrade.price, 140.91);
      expect(deserializedTrade.size, 4);
      expect(deserializedTrade.time, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(deserializedTrade.side, 'UNKNOWN_ORDER_SIDE');
      expect(deserializedTrade.bid, 291.13);
      expect(deserializedTrade.ask, 292.40);
    });
  });
}
