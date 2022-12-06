import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order_configuration/limit_gtc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order_configuration/limit_gtd.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order_configuration/market_ioc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order_configuration/stop_limit_gtc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order_configuration/stop_limit_gtd.dart';

class OrderConfiguration {
  final LimitGTC? limitGTC;
  final MarketIOC? marketIOC;
  final LimitGTD? limitGTD;
  final StopLimitGTC? stopLimitGTC;
  final StopLimitGTD? stopLimitGTD;

  OrderConfiguration(this.limitGTC, this.marketIOC, this.limitGTD,
      this.stopLimitGTC, this.stopLimitGTD);

  @override
  String toString() {
    String all = '{'
        'limitGTC=$limitGTC, marketIOC=$marketIOC, limitGTD=$limitGTD '
        'stopLimitGTC=$stopLimitGTC, stopLimitGTD=$stopLimitGTD'
        '}';
    return all;
  }

  String toJson() {
    Map<String, dynamic> map = {
      'marketIOC': marketIOC?.toJson(),
      'limitGTC': limitGTC?.toJson(),
      'limitGTD': limitGTD?.toJson(),
      'stopLimitGTC': stopLimitGTC?.toJson(),
      'stopLimitGTD': stopLimitGTD?.toJson(),
    };

    String body = jsonEncode(map);
    return body;
  }

  String toCoinbaseJson() {
    String body = '"order_configuration": {'
        '"market_market_ioc": ${marketIOC?.toCBJson()},'
        '"limit_limit_gtc": ${limitGTC?.toCBJson()},'
        '"limit_limit_gtd": ${limitGTD?.toCBJson()},'
        '"stop_limit_stop_limit_gtc": ${stopLimitGTC?.toCBJson()},'
        '"stop_limit_stop_limit_gtd": ${stopLimitGTD?.toCBJson()}'
        '}';
    return body;
  }

  static OrderConfiguration convertJson(var jsonObject) {
    LimitGTC? limitGTC;
    MarketIOC? marketIOC;
    LimitGTD? limitGTD;
    StopLimitGTC? stopLimitGTC;
    StopLimitGTD? stopLimitGTD;

    if (jsonObject['limit_limit_gtc'] != null) {
      limitGTC = LimitGTC.convertJson(jsonObject['limit_limit_gtc']);
    }
    if (jsonObject['market_market_ioc'] != null) {
      marketIOC = MarketIOC.convertJson(jsonObject['market_market_ioc']);
    }
    if (jsonObject['limit_limit_gtd'] != null) {
      limitGTD = LimitGTD.convertJson(jsonObject['limit_limit_gtd']);
    }
    if (jsonObject['stop_limit_stop_limit_gtc'] != null) {
      stopLimitGTC =
          StopLimitGTC.convertJson(jsonObject['stop_limit_stop_limit_gtc']);
    }
    if (jsonObject['stop_limit_stop_limit_gtd'] != null) {
      stopLimitGTD =
          StopLimitGTD.convertJson(jsonObject['stop_limit_stop_limit_gtd']);
    }
    return OrderConfiguration(
        limitGTC, marketIOC, limitGTD, stopLimitGTC, stopLimitGTD);
  }
}
