import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class StopLimitGTD {
  final double? quoteSize;
  final double? baseSize;
  final double? limitPrice;
  final double? stopPrice;
  final DateTime? endTime;
  final String? stopDirection;

  StopLimitGTD(this.quoteSize, this.baseSize, this.limitPrice, this.stopPrice,
      this.endTime, this.stopDirection);

  String? toCBJson() {
    if (quoteSize != null || baseSize != null) {
      Map<String, dynamic> map = {
        'quote_size': quoteSize,
        'base_size': baseSize,
        'limit_price': limitPrice,
        'stop_price': stopPrice,
        'end_time': endTime?.toIso8601String(),
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
      'endTime': endTime?.toIso8601String(),
      'stopDirection': stopDirection,
    };

    String body = jsonEncode(map);
    return body;
  }

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize, limitPrice=$limitPrice, '
        'stopPrice=$stopPrice, endTime=$endTime, stopDirection=$stopDirection'
        '}';
    return all;
  }

  static StopLimitGTD convertJson(var jsonObject) {
    double? quoteSize = nullableDouble(jsonObject, 'quote_size');
    double? baseSize = nullableDouble(jsonObject, 'base_size');
    double? limitPrice = nullableDouble(jsonObject, 'limit_price');
    double? stopPrice = nullableDouble(jsonObject, 'stop_price');
    DateTime? endTime = DateTime.parse(jsonObject['end_time']);
    String? stopDirection = jsonObject['stop_direction'];

    return StopLimitGTD(
        quoteSize, baseSize, limitPrice, stopPrice, endTime, stopDirection);
  }
}
