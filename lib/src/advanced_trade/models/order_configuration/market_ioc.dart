import 'package:coinbase_cloud_advanced_trade_client/src/shared/services/tools.dart';

class MarketIOC {
  final double? quoteSize;
  final double? baseSize;

  MarketIOC(this.quoteSize, this.baseSize);

  MarketIOC.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'];

  Map<String, dynamic> toJson() =>
      {'quoteSize': quoteSize, 'baseSize': baseSize};

  MarketIOC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size');

  Map<String, dynamic> toCBJson() =>
      {'quote_size': quoteSize, 'base_size': baseSize};

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize'
        '}';
    return all;
  }
}
