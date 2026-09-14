import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

import '../stop_direction.dart';

/// A stop-limit order that is good until a certain time.
class StopLimitGTD {
  /// The amount of quote currency to spend on the order.
  final Decimal? quoteSize;

  /// The amount of base currency to spend on the order.
  final Decimal? baseSize;

  /// The price at which to limit the order.
  final Decimal? limitPrice;

  /// The price at which to stop the order.
  final Decimal? stopPrice;

  /// The time at which the order will be canceled.
  final DateTime? endTime;

  /// The direction of the stop.
  final StopDirection? stopDirection;

  /// StopLimitGTD constructor
  StopLimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.endTime, this.stopDirection);

  /// Creates a StopLimitGTD from a JSON object.
  StopLimitGTD.fromJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quoteSize'),
        baseSize = nullableDecimal(json, 'baseSize'),
        limitPrice = nullableDecimal(json, 'limitPrice'),
        stopPrice = nullableDecimal(json, 'stopPrice'),
        endTime = json['endTime'],
        stopDirection = json['stopDirection'] != null
            ? StopDirection.fromCB(json['stopDirection'])
            : null;

  /// Converts a StopLimitGTD to a JSON object.
  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize?.toString(),
        'baseSize': baseSize?.toString(),
        'limitPrice': limitPrice?.toString(),
        'stopPrice': stopPrice?.toString(),
        'endTime': endTime?.toIso8601String(),
        'stopDirection': stopDirection?.toCB()
      };

  /// Creates a StopLimitGTD from a Coinbase JSON object.
  StopLimitGTD.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quote_size'),
        baseSize = nullableDecimal(json, 'base_size'),
        limitPrice = nullableDecimal(json, 'limit_price'),
        stopPrice = nullableDecimal(json, 'stop_price'),
        endTime = DateTime.parse(json['end_time']),
        stopDirection = json['stop_direction'] != null
            ? StopDirection.fromCB(json['stop_direction'])
            : null;

  /// Converts a StopLimitGTD to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize?.toString(),
        'base_size': baseSize?.toString(),
        'limit_price': limitPrice?.toString(),
        'stop_price': stopPrice?.toString(),
        'end_time': endTime?.toIso8601String(),
        'stop_direction': stopDirection?.toCB(),
      };

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'stopPrice=$stopPrice, endTime=$endTime, stopDirection=$stopDirection'
        '}';
    return all;
  }
}
