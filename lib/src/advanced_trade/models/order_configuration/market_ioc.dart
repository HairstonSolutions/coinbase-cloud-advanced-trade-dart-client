import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class MarketIOC {
  final double? quoteSize;
  final double? baseSize;

  MarketIOC(this.quoteSize, this.baseSize);

  String? toCBJson() {
    if (quoteSize != null || baseSize != null) {
      Map<String, dynamic> map = {
        'quote_size': quoteSize,
        'base_size': baseSize
      };

      String body = jsonEncode(map);
      return body;
    }
    return null;
  }

  String? toJson() {
    Map<String, dynamic> map = {'quoteSize': quoteSize, 'baseSize': baseSize};

    String body = jsonEncode(map);
    return body;
  }

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize'
        '}';
    return all;
  }

  static MarketIOC convertJson(var jsonObject) {
    double? quoteSize = nullableDouble(jsonObject, 'quote_size');
    double? baseSize = nullableDouble(jsonObject, 'base_size');

    return MarketIOC(quoteSize, baseSize);
  }
}
