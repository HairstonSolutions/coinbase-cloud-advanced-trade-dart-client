import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_configuration/limit_gtc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_configuration/limit_gtd.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_configuration/market_ioc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_configuration/stop_limit_gtc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_configuration/stop_limit_gtd.dart';

/// The configuration for an order.
class OrderConfiguration {
  /// A limit order that is good until canceled.
  final LimitGTC? limitGTC;

  /// A market order that is immediate or cancel.
  final MarketIOC? marketIOC;

  /// A limit order that is good until a specific time.
  final LimitGTD? limitGTD;

  /// A stop limit order that is good until canceled.
  final StopLimitGTC? stopLimitGTC;

  /// A stop limit order that is good until a specific time.
  final StopLimitGTD? stopLimitGTD;

  /// OrderConfiguration constructor
  OrderConfiguration(this.limitGTC, this.marketIOC, this.limitGTD,
      this.stopLimitGTC, this.stopLimitGTD);

  /// Creates an OrderConfiguration from a JSON object.
  OrderConfiguration.fromJson(Map<String, dynamic> json)
      : limitGTC = (json['limitGTC'] != null) ? json['limitGTC'] : null,
        marketIOC = (json['marketIOC'] != null) ? json['marketIOC'] : null,
        limitGTD = (json['limitGTD'] != null) ? json['limitGTD'] : null,
        stopLimitGTC =
            (json['stopLimitGTC'] != null) ? json['stopLimitGTC'] : null,
        stopLimitGTD =
            (json['stopLimitGTD'] != null) ? json['stopLimitGTD'] : null;

  /// Converts an OrderConfiguration to a JSON object.
  Map<String, dynamic> toJson() => {
        'marketIOC': marketIOC?.toJson(),
        'limitGTC': limitGTC?.toJson(),
        'limitGTD': limitGTD?.toJson(),
        'stopLimitGTC': stopLimitGTC?.toJson(),
        'stopLimitGTD': stopLimitGTD?.toJson(),
      };

  /// Creates an OrderConfiguration from a Coinbase JSON object.
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

  /// Converts an OrderConfiguration to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() {
    Map<String, dynamic> config = {};

    if (marketIOC != null &&
        (marketIOC?.quoteSize != null || marketIOC?.baseSize != null)) {
      config.addAll({'market_market_ioc': marketIOC?.toCBJson()});
    }
    if (limitGTC != null && (limitGTC?.baseSize != null)) {
      config.addAll({'limit_limit_gtc': limitGTC?.toCBJson()});
    }
    if (limitGTD != null && (limitGTD?.baseSize != null)) {
      config.addAll({'limit_limit_gtd': limitGTD?.toCBJson()});
    }
    if (stopLimitGTC != null && (stopLimitGTC?.baseSize != null)) {
      config.addAll({'stop_limit_stop_limit_gtc': stopLimitGTC?.toCBJson()});
    }
    if (stopLimitGTD != null && (stopLimitGTD?.baseSize != null)) {
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
