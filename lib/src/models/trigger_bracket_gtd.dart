import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class TriggerBracketGtd extends OrderConfiguration {
  final String baseSize;
  final String limitPrice;
  final String stopTriggerPrice;
  final String endTime;

  TriggerBracketGtd(
      {required this.baseSize,
      required this.limitPrice,
      required this.stopTriggerPrice,
      required this.endTime});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_size'] = baseSize;
    data['limit_price'] = limitPrice;
    data['stop_trigger_price'] = stopTriggerPrice;
    data['end_time'] = endTime;
    return {'trigger_bracket_gtd': data};
  }
}
