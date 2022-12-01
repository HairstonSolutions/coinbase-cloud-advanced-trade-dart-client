import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class LimitGTD {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final DateTime? endTime;
  final bool? postOnly;

  LimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.endTime,
      this.postOnly);

  String? toCBJson() {
    if (quoteSize != null || baseSize != null) {
      Map<String, dynamic> map = {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'end_time': endTime?.toIso8601String(),
        'post_only': postOnly,
      };

      String body = jsonEncode(map);
      return body;
    }
    return null;
  }

  String? toJson() {
    Map<String, dynamic> map = {
      'quoteSize': quoteSize,
      'baseSize': baseSize,
      'limitPrice': limitPrice,
      'endTime': endTime?.toIso8601String(),
      'postOnly': postOnly,
    };

    String body = jsonEncode(map);
    return body;
  }

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
