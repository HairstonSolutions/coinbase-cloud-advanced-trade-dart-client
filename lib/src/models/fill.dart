import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

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

  Fill.fromJson(Map<String, dynamic> json)
      : entryId = json['entryId'],
        tradeId = json['tradeId'],
        orderId = json['orderId'],
        tradeTime = DateTime.parse(json['tradeTime']),
        tradeType = json['tradeType'],
        price = json['price'],
        size = json['size'],
        commission = json['commission'],
        productId = json['productId'],
        sequenceTimestamp = DateTime.parse(json['sequenceTimestamp']),
        liquidityIndicator = json['liquidityIndicator'],
        sizeInQuote = json['sizeInQuote'],
        userId = json['userId'],
        side = json['side'];

  Map<String, dynamic> toJson() => {
        'entryId': entryId,
        'tradeId': tradeId,
        'orderId': orderId,
        'tradeTime': tradeTime?.toIso8601String(),
        'tradeType': tradeType,
        'price': price,
        'size': size,
        'commission': commission,
        'productId': productId,
        'sequenceTimestamp': sequenceTimestamp?.toIso8601String(),
        'liquidityIndicator': liquidityIndicator,
        'sizeInQuote': sizeInQuote,
        'userId': userId,
        'side': side
      };

  Fill.fromCBJson(Map<String, dynamic> json)
      : entryId = json['entry_id'] ?? '',
        tradeId = json['trade_id'] ?? '',
        orderId = json['order_id'] ?? '',
        tradeTime = DateTime.parse(json['trade_time']),
        tradeType = json['trade_type'] ?? '',
        price = nullableDouble(json, 'price'),
        size = nullableDouble(json, 'size'),
        commission = nullableDouble(json, 'commission'),
        productId = json['product_id'] ?? '',
        sequenceTimestamp = DateTime.parse(json['sequence_timestamp']),
        liquidityIndicator = json['liquidity_indicator'] ?? '',
        sizeInQuote = json['size_in_quote'] ?? false,
        userId = json['user_id'] ?? '',
        side = json['side'] ?? '';

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
}
