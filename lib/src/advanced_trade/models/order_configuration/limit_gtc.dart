import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class LimitGTC {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final bool? postOnly;

  LimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.postOnly);

  String? toCBJson() {
    if (quoteSize != null || baseSize != null) {
      Map<String, dynamic> map = {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
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
      'postOnly': postOnly,
    };

    String body = jsonEncode(map);
    return body;
  }

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'postOnly=$postOnly'
        '}';
    return all;
  }

  static LimitGTC convertJson(var jsonObject) {
    double? quoteSize = nullableDouble(jsonObject, 'quote_size');
    double? baseSize = nullableDouble(jsonObject, 'base_size');
    double? limitPrice = nullableDouble(jsonObject, 'limit_price');
    bool? postOnly = jsonObject['post_only'];

    return LimitGTC(quoteSize, baseSize, limitPrice, postOnly);
  }
}
