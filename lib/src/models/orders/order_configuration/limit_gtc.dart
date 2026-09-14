import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A limit order that is good until canceled.
class LimitGTC {
  /// The amount of quote currency to spend on the order.
  final Decimal? quoteSize;

  /// The amount of base currency to spend on the order.
  final Decimal? baseSize;

  /// The price at which to limit the order.
  final Decimal? limitPrice;

  /// Whether the order is post-only.
  final bool? postOnly;

  /// LimitGTC constructor
  LimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.postOnly);

  /// Creates a LimitGTC from a JSON object.
  LimitGTC.fromJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quoteSize'),
        baseSize = nullableDecimal(json, 'baseSize'),
        limitPrice = nullableDecimal(json, 'limitPrice'),
        postOnly = json['postOnly'];

  /// Converts a LimitGTC to a JSON object.
  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize?.toString(),
        'baseSize': baseSize?.toString(),
        'limitPrice': limitPrice?.toString(),
        'postOnly': postOnly
      };

  /// Creates a LimitGTC from a Coinbase JSON object.
  LimitGTC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quote_size'),
        baseSize = nullableDecimal(json, 'base_size'),
        limitPrice = nullableDecimal(json, 'limit_price'),
        postOnly = json['post_only'];

  /// Converts a LimitGTC to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize?.toString(),
        'base_size': baseSize?.toString(),
        'limit_price': limitPrice?.toString(),
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
