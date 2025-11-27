import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

import '../stop_direction.dart';

/// A stop-limit order that is good until a certain time.
class StopLimitGTD {
  /// The amount of quote currency to spend on the order.
  final double? quoteSize;

  /// The amount of base currency to spend on the order.
  final double? baseSize;

  /// The price at which to limit the order.
  final double? limitPrice;

  /// The price at which to stop the order.
  final double? stopPrice;

  /// The time at which the order will be canceled.
  final DateTime? endTime;

  /// The direction of the stop.
  final StopDirection? stopDirection;

  /// StopLimitGTD constructor
  StopLimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.endTime, this.stopDirection);

  /// Creates a StopLimitGTD from a JSON object.
  StopLimitGTD.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        stopPrice = json['stopPrice'],
        endTime = json['endTime'],
        stopDirection = json['stopDirection'] != null
            ? StopDirection.fromCB(json['stopDirection'])
            : null;

  /// Converts a StopLimitGTD to a JSON object.
  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'stopPrice': stopPrice,
        'endTime': endTime?.toIso8601String(),
        'stopDirection': stopDirection?.toCB()
      };

  /// Creates a StopLimitGTD from a Coinbase JSON object.
  StopLimitGTD.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        stopPrice = nullableDouble(json, 'stop_price'),
        endTime = DateTime.parse(json['end_time']),
        stopDirection = json['stop_direction'] != null
            ? StopDirection.fromCB(json['stop_direction'])
            : null;

  /// Converts a StopLimitGTD to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'stop_price': stopPrice,
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
