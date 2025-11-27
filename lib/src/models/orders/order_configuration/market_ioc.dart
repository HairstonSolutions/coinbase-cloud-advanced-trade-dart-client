import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

/// A market order that is immediate or cancel.
class MarketIOC {
  /// The amount of quote currency to spend on the order.
  final double? quoteSize;

  /// The amount of base currency to spend on the order.
  final double? baseSize;

  /// MarketIOC constructor
  MarketIOC(this.quoteSize, this.baseSize);

  /// Creates a MarketIOC from a JSON object.
  MarketIOC.fromJson(Map<String, dynamic> json)
      : quoteSize = json['quoteSize'],
        baseSize = json['baseSize'];

  /// Converts a MarketIOC to a JSON object.
  Map<String, dynamic> toJson() =>
      {'quoteSize': quoteSize, 'baseSize': baseSize};

  /// Creates a MarketIOC from a Coinbase JSON object.
  MarketIOC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDouble(json, 'quote_size'),
        baseSize = nullableDouble(json, 'base_size');

  /// Converts a MarketIOC to a Coinbase JSON object.
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
