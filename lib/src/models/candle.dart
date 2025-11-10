class Candle {
  final String start;
  final String high;
  final String low;
  final String open;
  final String close;
  final String volume;

  Candle({
    required this.start,
    required this.high,
    required this.low,
    required this.open,
    required this.close,
    required this.volume,
  });

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
