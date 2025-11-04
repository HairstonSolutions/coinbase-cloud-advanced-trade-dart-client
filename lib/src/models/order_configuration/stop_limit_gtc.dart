import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

class StopLimitGTC extends OrderConfiguration {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final double? stopPrice;
  final String? stopDirection;

  StopLimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.stopDirection)
      : super();

  StopLimitGTC.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        stopPrice = json['stopPrice'],
        stopDirection = json['stopDirection'];

  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'stopPrice': stopPrice,
        'stopDirection': stopDirection
      };

  StopLimitGTC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        stopPrice = nullableDouble(json, 'stop_price'),
        stopDirection = json['stop_direction'];

  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'stop_price': stopPrice,
        'stop_direction': stopDirection,
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
