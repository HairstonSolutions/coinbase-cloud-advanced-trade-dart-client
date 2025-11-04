import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class LimitLimitGtd extends OrderConfiguration {
  final String? quoteSize;
  final String? baseSize;
  final String limitPrice;
  final String endTime;
  final bool postOnly;

  LimitLimitGtd(
      {this.quoteSize,
      this.baseSize,
      required this.limitPrice,
      required this.endTime,
      this.postOnly = false});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quoteSize != null) data['quote_size'] = quoteSize;
    if (baseSize != null) data['base_size'] = baseSize;
    data['limit_price'] = limitPrice;
    data['end_time'] = endTime;
    data['post_only'] = postOnly;
    return {'limit_limit_gtd': data};
  }
}
