import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

class StopLimitGTD extends OrderConfiguration {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final double? stopPrice;
  final DateTime? endTime;
  final String? stopDirection;

  StopLimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.endTime, this.stopDirection)
      : super();

  StopLimitGTD.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        stopPrice = json['endTime'],
        endTime = json['endTime'],
        stopDirection = json['stopDirection'];

  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'stopPrice': stopPrice,
        'endTime': endTime?.toIso8601String(),
        'stopDirection': stopDirection
      };

  StopLimitGTD.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        stopPrice = nullableDouble(json, 'stop_price'),
        endTime = DateTime.parse(json['end_time']),
        stopDirection = json['stop_direction'];

  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'stop_price': stopPrice,
        'end_time': endTime?.toIso8601String(),
        'stop_direction': stopDirection,
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
