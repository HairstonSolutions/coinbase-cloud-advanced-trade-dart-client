class Trade {
  final String tradeId;
  final String productId;
  final String price;
  final String size;
  final String time;
  final String side;
  final String exchange;

  Trade(this.tradeId, this.productId, this.price, this.size, this.time,
      this.side, this.exchange);

  factory Trade.fromCBJson(Map<String, dynamic> json) {
    return Trade(
      json['trade_id'],
      json['product_id'],
      json['price'],
      json['size'],
      json['time'],
      json['side'],
      json['exchange'],
    );
  }
}
