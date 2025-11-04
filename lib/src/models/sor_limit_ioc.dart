import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class SorLimitIoc extends OrderConfiguration {
  final String? quoteSize;
  final String? baseSize;
  final String limitPrice;

  SorLimitIoc({this.quoteSize, this.baseSize, required this.limitPrice});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quoteSize != null) data['quote_size'] = quoteSize;
    if (baseSize != null) data['base_size'] = baseSize;
    data['limit_price'] = limitPrice;
    return {'sor_limit_ioc': data};
  }
}
