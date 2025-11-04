import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class TriggerBracketGtc extends OrderConfiguration {
  final String baseSize;
  final String limitPrice;
  final String stopTriggerPrice;

  TriggerBracketGtc(
      {required this.baseSize,
      required this.limitPrice,
      required this.stopTriggerPrice});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_size'] = baseSize;
    data['limit_price'] = limitPrice;
    data['stop_trigger_price'] = stopTriggerPrice;
    return {'trigger_bracket_gtc': data};
  }
}
