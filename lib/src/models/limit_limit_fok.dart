import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class LimitLimitFok extends OrderConfiguration {
  final String? quoteSize;
  final String? baseSize;
  final String limitPrice;

  LimitLimitFok({this.quoteSize, this.baseSize, required this.limitPrice});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quoteSize != null) data['quote_size'] = quoteSize;
    if (baseSize != null) data['base_size'] = baseSize;
    data['limit_price'] = limitPrice;
    return {'limit_limit_fok': data};
  }
}
