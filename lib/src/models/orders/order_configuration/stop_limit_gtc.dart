import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

import '../stop_direction.dart';

/// A stop-limit order that is good until canceled.
class StopLimitGTC {
  /// The amount of quote currency to spend on the order.
  final Decimal? quoteSize;

  /// The amount of base currency to spend on the order.
  final Decimal? baseSize;

  /// The price at which to limit the order.
  final Decimal? limitPrice;

  /// The price at which to stop the order.
  final Decimal? stopPrice;

  /// The direction of the stop.
  final StopDirection? stopDirection;

  /// StopLimitGTC constructor
  StopLimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.stopDirection);

  /// Creates a StopLimitGTC from a JSON object.
  StopLimitGTC.fromJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quoteSize'),
        baseSize = nullableDecimal(json, 'baseSize'),
        limitPrice = nullableDecimal(json, 'limitPrice'),
        stopPrice = nullableDecimal(json, 'stopPrice'),
        stopDirection = json['stopDirection'] != null
            ? StopDirection.fromCB(json['stopDirection'])
            : null;

  /// Converts a StopLimitGTC to a JSON object.
  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize?.toString(),
        'baseSize': baseSize?.toString(),
        'limitPrice': limitPrice?.toString(),
        'stopPrice': stopPrice?.toString(),
        'stopDirection': stopDirection?.toCB()
      };

  /// Creates a StopLimitGTC from a Coinbase JSON object.
  StopLimitGTC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quote_size'),
        baseSize = nullableDecimal(json, 'base_size'),
        limitPrice = nullableDecimal(json, 'limit_price'),
        stopPrice = nullableDecimal(json, 'stop_price'),
        stopDirection = json['stop_direction'] != null
            ? StopDirection.fromCB(json['stop_direction'])
            : null;

  /// Converts a StopLimitGTC to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize?.toString(),
        'base_size': baseSize?.toString(),
        'limit_price': limitPrice?.toString(),
        'stop_price': stopPrice?.toString(),
        'stop_direction': stopDirection?.toCB(),
      };

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'stopPrice=$stopPrice, stopDirection=$stopDirection'
        '}';
    return all;
  }
}
