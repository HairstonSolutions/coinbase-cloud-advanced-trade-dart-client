import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/scaled_order.dart';

class ScaledLimitGtc extends OrderConfiguration {
  final List<ScaledOrder> orders;
  final String? quoteSize;
  final String? baseSize;
  final int numOrders;
  final String minPrice;
  final String maxPrice;
  final String priceDistribution;
  final String sizeDistribution;
  final String? sizeDiff;
  final String? sizeRatio;

  ScaledLimitGtc(
      {required this.orders,
      this.quoteSize,
      this.baseSize,
      required this.numOrders,
      required this.minPrice,
      required this.maxPrice,
      required this.priceDistribution,
      required this.sizeDistribution,
      this.sizeDiff,
      this.sizeRatio});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orders'] = orders.map((v) => v.toJson()).toList();
    if (quoteSize != null) data['quote_size'] = quoteSize;
    if (baseSize != null) data['base_size'] = baseSize;
    data['num_orders'] = numOrders;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['price_distribution'] = priceDistribution;
    data['size_distribution'] = sizeDistribution;
    if (sizeDiff != null) data['size_diff'] = sizeDiff;
    if (sizeRatio != null) data['size_ratio'] = sizeRatio;
    return {'scaled_limit_gtc': data};
  }
}
