import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

class LimitGTC {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final bool? postOnly;

  LimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.postOnly);

  LimitGTC.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'],
        limitPrice = json['limitPrice'],
        postOnly = json['postOnly'];

  Map<String, dynamic> toJson() => {
        'quoteSize': quoteSize,
        'baseSize': baseSize,
        'limitPrice': limitPrice,
        'postOnly': postOnly
      };

  LimitGTC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size'),
        limitPrice = nullableDouble(json, 'limit_price'),
        postOnly = json['post_only'];

  Map<String, dynamic> toCBJson() => {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'post_only': postOnly
      };

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'postOnly=$postOnly'
        '}';
    return all;
  }
}
