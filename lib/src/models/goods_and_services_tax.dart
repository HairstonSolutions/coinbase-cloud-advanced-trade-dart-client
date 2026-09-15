import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A goods and services tax.
class GoodsAndServicesTax {
  /// The rate of the tax.
  final Decimal rate;

  /// The type of the tax.
  final String type;

  /// GoodsAndServicesTax constructor
  GoodsAndServicesTax({required this.rate, required this.type});

  /// Creates a GoodsAndServicesTax from a Coinbase JSON object.
  factory GoodsAndServicesTax.fromCBJson(Map<String, dynamic> json) {
    return GoodsAndServicesTax(
      rate: requiredDecimal(json, 'rate', allowNum: true),
      type: json['type'],
    );
  }

  @override
  String toString() {
    return 'GoodsAndServicesTax{rate: $rate, type: $type}';
  }
}
