import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

import '../stop_direction.dart';

class StopLimitGTD {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final double? stopPrice;
  final DateTime? endTime;
  final StopDirection? stopDirection;

  StopLimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.endTime, this.stopDirection);

  StopLimitGTD.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        stopPrice = json['stopPrice'],
        endTime = json['endTime'],
        stopDirection = json['stopDirection'] != null
            ? StopDirection.fromCB(json['stopDirection'])
            : null;

  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'stopPrice': stopPrice,
        'endTime': endTime?.toIso8601String(),
        'stopDirection': stopDirection?.toCB()
      };

  StopLimitGTD.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        stopPrice = nullableDouble(json, 'stop_price'),
        endTime = DateTime.parse(json['end_time']),
        stopDirection = json['stop_direction'] != null
            ? StopDirection.fromCB(json['stop_direction'])
            : null;

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
