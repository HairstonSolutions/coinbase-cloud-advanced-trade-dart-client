/// A candle for a product.
class Candle {
  /// The start time of the candle.
  final String start;

  /// The highest price of the candle.
  final String high;

  /// The lowest price of the candle.
  final String low;

  /// The opening price of the candle.
  final String open;

  /// The closing price of the candle.
  final String close;

  /// The volume of the candle.
  final String volume;

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
      high: json['high'],
      low: json['low'],
      open: json['open'],
      close: json['close'],
      volume: json['volume'],
    );
  }

  @override
  String toString() {
    return '{start: $start, high: $high, low: $low, open: $open, close: $close, volume: $volume}';
  }
}
