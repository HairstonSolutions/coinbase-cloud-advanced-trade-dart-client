import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class LimitGTD {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final DateTime? endTime;
  final bool? postOnly;

  LimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.endTime,
      this.postOnly);

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'endTime=$endTime, postOnly=$postOnly'
        '}';
    return all;
  }

  static LimitGTD convertJson(var jsonObject) {
    double? quoteSize = nullableDouble(jsonObject, 'quote_size');
    double? baseSize = nullableDouble(jsonObject, 'base_size');
    double? limitPrice = nullableDouble(jsonObject, 'limit_price');
    DateTime? endTime = DateTime.parse(jsonObject['end_time']);
    bool? postOnly = jsonObject['post_only'];

    return LimitGTD(quoteSize, baseSize, limitPrice, endTime, postOnly);
  }
}
