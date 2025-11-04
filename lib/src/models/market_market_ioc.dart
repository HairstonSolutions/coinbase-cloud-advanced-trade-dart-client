import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class MarketMarketIoc extends OrderConfiguration {
  final String? quoteSize;
  final String? baseSize;

  MarketMarketIoc({this.quoteSize, this.baseSize});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quoteSize != null) data['quote_size'] = quoteSize;
    if (baseSize != null) data['base_size'] = baseSize;
    return {'market_market_ioc': data};
  }
}
