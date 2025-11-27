import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

/// A limit order that is good until canceled.
class LimitGTC {
  /// The amount of quote currency to spend on the order.
  final double? quoteSize;

  /// The amount of base currency to spend on the order.
  final double? baseSize;

  /// The price at which to limit the order.
  final double? limitPrice;

  /// Whether the order is post-only.
  final bool? postOnly;

  /// LimitGTC constructor
  LimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.postOnly);

  /// Creates a LimitGTC from a JSON object.
  LimitGTC.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        postOnly = json['postOnly'];

  /// Converts a LimitGTC to a JSON object.
  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'postOnly': postOnly
      };

  /// Creates a LimitGTC from a Coinbase JSON object.
  LimitGTC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        postOnly = json['post_only'];

  /// Converts a LimitGTC to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'post_only': postOnly
      };

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'postOnly=$postOnly'
        '}';
    return all;
  }
}
