import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

import '../stop_direction.dart';

class StopLimitGTC {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final double? stopPrice;
  final StopDirection? stopDirection;

  StopLimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.stopDirection);

  StopLimitGTC.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        stopPrice = json['stopPrice'],
        stopDirection = json['stopDirection'] != null
            ? StopDirection.fromCB(json['stopDirection'])
            : null;

  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'stopPrice': stopPrice,
        'stopDirection': stopDirection?.toCB()
      };

  StopLimitGTC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        stopPrice = nullableDouble(json, 'stop_price'),
        stopDirection = json['stop_direction'] != null
            ? StopDirection.fromCB(json['stop_direction'])
            : null;

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
