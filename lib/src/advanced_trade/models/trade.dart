import 'package:coinbase_cloud_advanced_trade_client/src/shared/services/tools.dart';

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

  Trade.fromCBJson(Map<String, dynamic> json)
      : tradeId = json['trade_id'],
        productId = json['product_id'],
        price = double.parse(json['price']),
        size = double.parse(json['size']),
        time = DateTime.parse(json['time']),
        side = json['side'],
        bid = nullableDouble(json, 'bid'),
        ask = nullableDouble(json, 'ask');

  Map<String, dynamic> toCBJson() => {
        'trade_id': tradeId,
        'product_id': productId,
        'price': price,
        'size': size,
        'time': time?.toIso8601String(),
        'side': side,
        'bid': bid,
        'ask': ask,
      };

  Trade.fromJson(Map<String, dynamic> json)
      : tradeId = json['tradeId'],
        productId = json['productId'],
        price = json['price'],
        size = json['size'],
        time = DateTime.parse(json['time']),
        side = json['side'],
        bid = json['bid'],
        ask = json['ask'];

  Map<String, dynamic> toJson() => {
        'tradeId': tradeId,
        'productId': productId,
        'price': price,
        'size': size,
        'time': time?.toIso8601String(),
        'side': side,
        'bid': bid,
        'ask': ask,
      };

  @override
  String toString() {
    String all = '{'
        'tradeId=$tradeId, productId=$productId, price=$price, size=$size, '
        'time=$time, side=$side, bid=$bid, ask=$ask'
        '}';
    return all;
  }
}
