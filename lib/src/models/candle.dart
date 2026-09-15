import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A candle for a product.
class Candle {
  /// The start time of the candle.
  final String start;

  /// The highest price of the candle.
  final Decimal high;

  /// The lowest price of the candle.
  final Decimal low;

  /// The opening price of the candle.
  final Decimal open;

  /// The closing price of the candle.
  final Decimal close;

  /// The volume of the candle.
  final Decimal volume;

  /// Candle constructor
  Candle({
    required this.start,
    required this.high,
    required this.low,
    required this.open,
    required this.close,
    required this.volume,
  });

  /// Creates a Candle from a JSON object.
  factory Candle.fromJson(Map<String, dynamic> json) {
    return Candle(
      start: json['start'],
      high: requiredDecimal(json, 'high'),
      low: requiredDecimal(json, 'low'),
      open: requiredDecimal(json, 'open'),
      close: requiredDecimal(json, 'close'),
      volume: requiredDecimal(json, 'volume'),
    );
  }

  @override
  String toString() {
    return '{start: $start, high: $high, low: $low, open: $open, close: $close, volume: $volume}';
  }
}
