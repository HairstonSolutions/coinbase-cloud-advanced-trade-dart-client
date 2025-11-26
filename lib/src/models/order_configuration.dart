import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/limit_gtc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/limit_gtd.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/market_ioc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/stop_limit_gtc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/stop_limit_gtd.dart';

enum StopDirection {
  STOP_DIRECTION_STOP_DOWN,
  STOP_DIRECTION_STOP_UP;

  String toCB() {
    return name;
  }

  static StopDirection fromCB(String cb) {
    return StopDirection.values.firstWhere((e) => e.name == cb,
        orElse: () =>
            throw FormatException('Unknown StopDirection value: $cb'));
  }
}

class OrderConfiguration {
  final LimitGTC? limitGTC;
  final MarketIOC? marketIOC;
  final LimitGTD? limitGTD;
  final StopLimitGTC? stopLimitGTC;
  final StopLimitGTD? stopLimitGTD;

  OrderConfiguration(this.limitGTC, this.marketIOC, this.limitGTD,
      this.stopLimitGTC, this.stopLimitGTD);

  OrderConfiguration.fromJson(Map<String, dynamic> json)
      : limitGTC = (json['limitGTC'] != null) ? json['limitGTC'] : null,
        marketIOC = (json['marketIOC'] != null) ? json['marketIOC'] : null,
        limitGTD = (json['limitGTD'] != null) ? json['limitGTD'] : null,
        stopLimitGTC =
            (json['stopLimitGTC'] != null) ? json['stopLimitGTC'] : null,
        stopLimitGTD =
            (json['stopLimitGTD'] != null) ? json['stopLimitGTD'] : null;

  Map<String, dynamic> toJson() => {
        'marketIOC': marketIOC?.toJson(),
        'limitGTC': limitGTC?.toJson(),
        'limitGTD': limitGTD?.toJson(),
        'stopLimitGTC': stopLimitGTC?.toJson(),
        'stopLimitGTD': stopLimitGTD?.toJson(),
      };

  OrderConfiguration.fromCBJson(Map<String, dynamic> json)
      : limitGTC = (json['limit_limit_gtc'] != null)
            ? LimitGTC.fromCBJson(json['limit_limit_gtc'])
            : null,
        marketIOC = (json['market_market_ioc'] != null)
            ? MarketIOC.fromCBJson(json['market_market_ioc'])
            : null,
        limitGTD = (json['limit_limit_gtd'] != null)
            ? LimitGTD.fromCBJson(json['limit_limit_gtd'])
            : null,
        stopLimitGTC = (json['stop_limit_stop_limit_gtc'] != null)
            ? StopLimitGTC.fromCBJson(json['stop_limit_stop_limit_gtc'])
            : null,
        stopLimitGTD = (json['stop_limit_stop_limit_gtd'] != null)
            ? StopLimitGTD.fromCBJson(json['stop_limit_stop_limit_gtd'])
            : null;

  Map<String, dynamic> toCBJson() {
    Map<String, dynamic> config = {};

    if (marketIOC != null &&
        marketIOC?.quoteSize != null &&
        marketIOC?.baseSize != null) {
      config.addAll({'market_market_ioc': marketIOC?.toCBJson()});
    }
    if (limitGTC != null &&
        limitGTC?.quoteSize != null &&
        limitGTC?.baseSize != null) {
      config.addAll({'limit_limit_gtc': limitGTC?.toCBJson()});
    }
    if (limitGTD != null &&
        limitGTD?.quoteSize != null &&
        limitGTD?.baseSize != null) {
      config.addAll({'limit_limit_gtd': limitGTD?.toCBJson()});
    }
    if (stopLimitGTC != null &&
        stopLimitGTC?.quoteSize != null &&
        stopLimitGTC?.baseSize != null) {
      config.addAll({'stop_limit_stop_limit_gtc': stopLimitGTC?.toCBJson()});
    }
    if (stopLimitGTD != null &&
        stopLimitGTD?.quoteSize != null &&
        stopLimitGTD?.baseSize != null) {
      config.addAll({'stop_limit_stop_limit_gtd': stopLimitGTD?.toCBJson()});
    }

    return {'order_configuration': config};
  }

  @override
  String toString() {
    String all = '{'
        'limitGTC=$limitGTC, marketIOC=$marketIOC, limitGTD=$limitGTD '
        'stopLimitGTC=$stopLimitGTC, stopLimitGTD=$stopLimitGTD'
        '}';
    return all;
  }
}
