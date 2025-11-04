class Candle {
  final String start;
  final String low;
  final String high;
  final String open;
  final String close;
  final String volume;

  Candle(this.start, this.low, this.high, this.open, this.close, this.volume);

  factory Candle.fromCBJson(Map<String, dynamic> json) {
    return Candle(
      json['start'],
      json['low'],
      json['high'],
      json['open'],
      json['close'],
      json['volume'],
    );
  }
}
