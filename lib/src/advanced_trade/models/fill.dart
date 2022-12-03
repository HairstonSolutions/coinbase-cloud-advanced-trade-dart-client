class Fill {
  final String? entryId;
  final String? tradeId;
  final String? orderId;
  final DateTime? tradeTime;
  final String? tradeType;
  final double? price;
  final double? size;
  final double? commission;
  final String? productId;
  final DateTime? sequenceTimestamp;
  final String? liquidityIndicator;
  final bool? sizeInQuote;
  final String? userId;
  final String? side;

  Fill(
      this.entryId,
      this.tradeId,
      this.orderId,
      this.tradeTime,
      this.tradeType,
      this.price,
      this.size,
      this.commission,
      this.productId,
      this.sequenceTimestamp,
      this.liquidityIndicator,
      this.sizeInQuote,
      this.userId,
      this.side);

  @override
  String toString() {
    String all = '{'
        'entryId=$entryId, tradeId=$tradeId, orderId=$orderId, '
        'tradeTime=$tradeTime, tradeType=$tradeType, price=$price, size=$size, '
        'commission=$commission, productId=$productId, '
        'sequenceTimestamp=$sequenceTimestamp, '
        'liquidityIndicator=$liquidityIndicator, sizeInQuote=$sizeInQuote, '
        'userId=$userId, side=$side'
        '}';
    return all;
  }

  static Fill convertJson(var jsonObject) {
    String? entryId = jsonObject['entry_id'];
    String? tradeId = jsonObject['trade_id'];
    String? orderId = jsonObject['order_id'];
    DateTime? tradeTime = DateTime.parse(jsonObject['trade_time']);
    String? tradeType = jsonObject['trade_type'];
    double? price = double.parse(jsonObject['price']);
    double? size = double.parse(jsonObject['size']);
    double? commission = double.parse(jsonObject['commission']);
    String? productId = jsonObject['product_id'];
    DateTime? sequenceTimestamp =
        DateTime.parse(jsonObject['sequence_timestamp']);
    String? liquidityIndicator = jsonObject['liquidity_indicator'];
    bool? sizeInQuote = jsonObject['size_in_quote'];
    String? userId = jsonObject['user_id'];
    String? side = jsonObject['side'];

    return Fill(
        entryId,
        tradeId,
        orderId,
        tradeTime,
        tradeType,
        price,
        size,
        commission,
        productId,
        sequenceTimestamp,
        liquidityIndicator,
        sizeInQuote,
        userId,
        side);
  }
}
