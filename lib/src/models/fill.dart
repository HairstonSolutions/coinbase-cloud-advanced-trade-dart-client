import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

/// A fill for an order.
class Fill {
  /// The entry ID.
  final String? entryId;

  /// The trade ID.
  final String? tradeId;

  /// The order ID.
  final String? orderId;

  /// The time of the trade.
  final DateTime? tradeTime;

  /// The type of the trade.
  final String? tradeType;

  /// The price of the trade.
  final double? price;

  /// The size of the trade.
  final double? size;

  /// The commission for the trade.
  final double? commission;

  /// The product ID.
  final String? productId;

  /// The sequence timestamp.
  final DateTime? sequenceTimestamp;

  /// The liquidity indicator.
  final String? liquidityIndicator;

  /// Whether the size is in the quote currency.
  final bool? sizeInQuote;

  /// The user ID.
  final String? userId;

  /// The side of the order.
  final String? side;

  /// Fill constructor
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

  /// Creates a Fill from a JSON object.
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

  /// Converts a Fill to a JSON object.
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

  /// Creates a Fill from a Coinbase JSON object.
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
