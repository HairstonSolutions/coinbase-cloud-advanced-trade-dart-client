import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

/// A representation of a trade.
class Trade {
  /// The trade ID.
  final String? tradeId;

  /// The product ID.
  final String? productId;

  /// The price of the trade.
  final double? price;

  /// The size of the trade.
  final double? size;

  /// The time of the trade.
  final DateTime? time;

  /// The side of the trade.
  final String? side;

  /// The bid price at the time of the trade.
  final double? bid;

  /// The ask price at the time of the trade.
  final double? ask;

  /// Trade constructor
  Trade(this.tradeId, this.productId, this.price, this.size, this.time,
      this.side, this.bid, this.ask);

  /// Creates a Trade from a Coinbase JSON object.
  Trade.fromCBJson(Map<String, dynamic> json)
      : tradeId = json['trade_id'],
        productId = json['product_id'],
        price = double.parse(json['price']),
        size = double.parse(json['size']),
        time = DateTime.parse(json['time']),
        side = json['side'],
        bid = nullableDouble(json, 'bid'),
        ask = nullableDouble(json, 'ask');

  /// Converts a Trade to a Coinbase JSON object.
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

  /// Creates a Trade from a JSON object.
  Trade.fromJson(Map<String, dynamic> json)
      : tradeId = json['tradeId'],
        productId = json['productId'],
        price = json['price'],
        size = json['size'],
        time = DateTime.parse(json['time']),
        side = json['side'],
        bid = json['bid'],
        ask = json['ask'];

  /// Converts a Trade to a JSON object.
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
