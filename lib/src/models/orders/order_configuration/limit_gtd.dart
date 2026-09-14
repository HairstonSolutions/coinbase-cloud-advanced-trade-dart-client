import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A limit order that is good until a specific time.
class LimitGTD {
  /// The amount of quote currency to spend on the order.
  final Decimal? quoteSize;

  /// The amount of base currency to spend on the order.
  final Decimal? baseSize;

  /// The price at which to limit the order.
  final Decimal? limitPrice;

  /// The time at which the order will be canceled.
  final DateTime? endTime;

  /// Whether the order is post-only.
  final bool? postOnly;

  /// LimitGTD constructor
  LimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.endTime,
      this.postOnly);

  /// Creates a LimitGTD from a JSON object.
  LimitGTD.fromJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quoteSize'),
        baseSize = nullableDecimal(json, 'baseSize'),
        limitPrice = nullableDecimal(json, 'limitPrice'),
        endTime = json['endTime'],
        postOnly = json['postOnly'];

  /// Converts a LimitGTD to a JSON object.
  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize?.toString(),
        'baseSize': baseSize?.toString(),
        'limitPrice': limitPrice?.toString(),
        'endTime': endTime?.toIso8601String(),
        'postOnly': postOnly
      };

  /// Creates a LimitGTD from a Coinbase JSON object.
  LimitGTD.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quote_size'),
        baseSize = nullableDecimal(json, 'base_size'),
        limitPrice = nullableDecimal(json, 'limit_price'),
        endTime = DateTime.parse(json['end_time']),
        postOnly = json['post_only'];

  /// Converts a LimitGTD to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize?.toString(),
        'base_size': baseSize?.toString(),
        'limit_price': limitPrice?.toString(),
        'end_time': endTime?.toIso8601String(),
        'post_only': postOnly,
      };

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'endTime=$endTime, postOnly=$postOnly'
        '}';
    return all;
  }
}
