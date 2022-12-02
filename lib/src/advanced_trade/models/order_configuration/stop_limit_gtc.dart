import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class StopLimitGTC {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final double? stopPrice;
  final String? stopDirection;

  StopLimitGTC(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.stopDirection);

  String? toCBJson() {
    if (quoteSize != null || baseSize != null) {
      Map<String, dynamic> map = {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'stop_price': stopPrice,
        'stop_direction': stopDirection,
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
      'stopPrice': stopPrice,
      'stopDirection': stopDirection,
    };

    String body = jsonEncode(map);
    return body;
  }

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'stopPrice=$stopPrice, stopDirection=$stopDirection'
        '}';
    return all;
  }

  static StopLimitGTC convertJson(var jsonObject) {
    double? quoteSize = nullableDouble(jsonObject, 'quote_size');
    double? baseSize = nullableDouble(jsonObject, 'base_size');
    double? limitPrice = nullableDouble(jsonObject, 'limit_price');
    double? stopPrice = nullableDouble(jsonObject, 'stop_price');
    String? stopDirection = jsonObject['stop_direction'];

    return StopLimitGTC(
        quoteSize, baseSize, limitPrice, stopPrice, stopDirection);
  }
}
