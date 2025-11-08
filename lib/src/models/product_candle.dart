class ProductCandle {
  final String start;
  final String low;
  final String high;
  final String open;
  final String close;
  final String volume;

  ProductCandle(
      {required this.start,
      required this.low,
      required this.high,
      required this.open,
      required this.close,
      required this.volume});

  factory ProductCandle.fromCBJson(Map<String, dynamic> json) {
    return ProductCandle(
      start: json['start'],
      low: json['low'],
      high: json['high'],
      open: json['open'],
      close: json['close'],
      volume: json['volume'],
    );
  }
}
