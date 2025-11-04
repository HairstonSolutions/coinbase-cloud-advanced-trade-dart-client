import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class StopLimitStopLimitGtc extends OrderConfiguration {
  final String baseSize;
  final String limitPrice;
  final String stopPrice;
  final String stopDirection;

  StopLimitStopLimitGtc(
      {required this.baseSize,
      required this.limitPrice,
      required this.stopPrice,
      required this.stopDirection});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_size'] = baseSize;
    data['limit_price'] = limitPrice;
    data['stop_price'] = stopPrice;
    data['stop_direction'] = stopDirection;
    return {'stop_limit_stop_limit_gtc': data};
  }
}
