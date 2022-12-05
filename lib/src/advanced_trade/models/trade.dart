import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class Trade {
  final String? tradeId;
  final String? productId;
  final double? price;
  final double? size;
  final DateTime? time;
  final String? side;
  final double? bid;
  final double? ask;

  Trade(this.tradeId, this.productId, this.price, this.size, this.time,
      this.side, this.bid, this.ask);

  String? toCBJson() {
    Map<String, dynamic> map = {
      'trade_id': tradeId,
      'product_id': productId,
      'price': price,
      'size': size,
      'time': time?.toIso8601String(),
      'side': side,
      'bid': bid,
      'ask': ask,
    };
    String body = jsonEncode(map);
    return body;
  }

  String? toJson() {
    Map<String, dynamic> map = {
      'tradeId': tradeId,
      'productId': productId,
      'price': price,
      'size': size,
      'time': time?.toIso8601String(),
      'side': side,
      'bid': bid,
      'ask': ask,
    };
    String body = jsonEncode(map);
    return body;
  }

  @override
  String toString() {
    String all = '{'
        'tradeId=$tradeId, productId=$productId, price=$price, size=$size, '
        'time=$time, side=$side, bid=$bid, ask=$ask'
        '}';
    return all;
  }

  static Trade convertJson(var jsonObject) {
    String? tradeId = jsonObject['trade_id'];
    String? productId = jsonObject['product_id'];
    double? price = double.parse(jsonObject['price']);
    double? size = double.parse(jsonObject['size']);
    DateTime? time = DateTime.parse(jsonObject['time']);
    String? side = jsonObject['side'];
    double? bid = nullableDouble(jsonObject, 'bid');
    double? ask = nullableDouble(jsonObject, 'ask');

    return Trade(tradeId, productId, price, size, time, side, bid, ask);
  }
}
