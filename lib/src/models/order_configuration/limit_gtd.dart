import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

class LimitGTD {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final DateTime? endTime;
  final bool? postOnly;

  LimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.endTime,
      this.postOnly);

  LimitGTD.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        endTime = json['endTime'],
        postOnly = json['postOnly'];

  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'endTime': endTime?.toIso8601String(),
        'postOnly': postOnly
      };

  LimitGTD.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        endTime = DateTime.parse(json['end_time']),
        postOnly = json['post_only'];

  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
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
