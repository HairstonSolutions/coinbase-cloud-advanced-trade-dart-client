import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/limit_gtc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/limit_gtd.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/market_ioc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/stop_limit_gtc.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration/stop_limit_gtd.dart';

abstract class OrderConfiguration {
  OrderConfiguration();

  Map<String, dynamic> toJson();

  factory OrderConfiguration.fromCBJson(Map<String, dynamic> json) {
    if (json.containsKey('limit_limit_gtc')) {
      return LimitGTC.fromCBJson(json['limit_limit_gtc'])
          as OrderConfiguration;
    } else if (json.containsKey('limit_limit_gtd')) {
      return LimitGTD.fromCBJson(json['limit_limit_gtd'])
          as OrderConfiguration;
    } else if (json.containsKey('market_market_ioc')) {
      return MarketIOC.fromCBJson(json['market_market_ioc'])
          as OrderConfiguration;
    } else if (json.containsKey('stop_limit_stop_limit_gtc')) {
      return StopLimitGTC.fromCBJson(json['stop_limit_stop_limit_gtc'])
          as OrderConfiguration;
    } else if (json.containsKey('stop_limit_stop_limit_gtd')) {
      return StopLimitGTD.fromCBJson(json['stop_limit_stop_limit_gtd'])
          as OrderConfiguration;
    } else {
      throw Exception('Unknown order configuration type');
    }
  }
}
