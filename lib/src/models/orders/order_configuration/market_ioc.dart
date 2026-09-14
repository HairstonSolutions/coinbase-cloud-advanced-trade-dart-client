import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A market order that is immediate or cancel.
class MarketIOC {
  /// The amount of quote currency to spend on the order.
  final Decimal? quoteSize;

  /// The amount of base currency to spend on the order.
  final Decimal? baseSize;

  /// MarketIOC constructor
  MarketIOC(this.quoteSize, this.baseSize);

  /// Creates a MarketIOC from a JSON object.
  MarketIOC.fromJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quoteSize'),
        baseSize = nullableDecimal(json, 'baseSize');

  /// Converts a MarketIOC to a JSON object.
  Map<String, dynamic> toJson() =>
      {'quoteSize': quoteSize?.toString(), 'baseSize': baseSize?.toString()};

  /// Creates a MarketIOC from a Coinbase JSON object.
  MarketIOC.fromCBJson(Map<String, dynamic> json)
      : quoteSize = nullableDecimal(json, 'quote_size'),
        baseSize = nullableDecimal(json, 'base_size');

  /// Converts a MarketIOC to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() =>
      {'quote_size': quoteSize?.toString(), 'base_size': baseSize?.toString()};

  @override
  String toString() {
    String all = '{'
        'quoteSize=$quoteSize, baseSize=$baseSize'
        '}';
    return all;
  }
}
