import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class LimitLimitGtc extends OrderConfiguration {
  final String? quoteSize;
  final String? baseSize;
  final String limitPrice;
  final bool postOnly;

  LimitLimitGtc(
      {this.quoteSize,
      this.baseSize,
      required this.limitPrice,
      this.postOnly = false});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quoteSize != null) data['quote_size'] = quoteSize;
    if (baseSize != null) data['base_size'] = baseSize;
    data['limit_price'] = limitPrice;
    data['post_only'] = postOnly;
    return {'limit_limit_gtc': data};
  }
}
