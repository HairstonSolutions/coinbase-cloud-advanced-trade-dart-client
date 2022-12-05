import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/trade.dart';
import 'package:test/test.dart';

import '../../tools.dart';

void main() {
  group('Test Trade Object Injection', () {
    String exampleTradeJsonFile = 'advanced_trade/models/examples/trade.json';
    String? exampleTradeJson;

    setUp(() async {
      exampleTradeJson = await getJsonFromFile(exampleTradeJsonFile);
    });

    test('Test Example Trade JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleTradeJson!);
      Trade? exampleTrade = Trade.convertJson(jsonAsMap);

      print('Trade Object: $exampleTrade');
      print('Trade jsonEncoded: ${exampleTrade.toJson()}');
      print('Trade CB jsonEncoded: ${exampleTrade.toCBJson()}');

      expect(exampleTrade.tradeId, '34b080bf-fcfd-445a-832b-46b5ddc65601');
      expect(exampleTrade.productId, 'BTC-USD');
      expect(exampleTrade.price, 140.91);
      expect(exampleTrade.size, 4);
      expect(exampleTrade.time, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleTrade.side, 'UNKNOWN_ORDER_SIDE');
      expect(exampleTrade.bid, 291.13);
      expect(exampleTrade.ask, 292.40);
    });
  });
}
