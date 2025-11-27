import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

import '../stop_direction.dart';

/// A stop-limit order that is good until canceled.
class StopLimitGTC {
  /// The amount of quote currency to spend on the order.
  final double? quoteSize;

  /// The amount of base currency to spend on the order.
  final double? baseSize;

  /// The price at which to limit the order.
  final double? limitPrice;

  /// The price at which to stop the order.
  final double? stopPrice;

  /// The direction of the stop.
  final StopDirection? stopDirection;

  /// StopLimitGTC constructor
  StopLimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.stopDirection);

  /// Creates a StopLimitGTC from a JSON object.
  StopLimitGTC.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        stopPrice = json['stopPrice'],
        stopDirection = json['stopDirection'] != null
            ? StopDirection.fromCB(json['stopDirection'])
            : null;

  /// Converts a StopLimitGTC to a JSON object.
  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'stopPrice': stopPrice,
        'stopDirection': stopDirection?.toCB()
      };

  /// Creates a StopLimitGTC from a Coinbase JSON object.
  StopLimitGTC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        stopPrice = nullableDouble(json, 'stop_price'),
        stopDirection = json['stop_direction'] != null
            ? StopDirection.fromCB(json['stop_direction'])
            : null;

  /// Converts a StopLimitGTC to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'stop_price': stopPrice,
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
