import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// The response from a preview order request.
class PreviewOrderResponse {
  /// The total cost of the order.
  final Decimal? orderTotal;

  /// The total commission for the order.
  final Decimal? commissionTotal;

  /// A list of errors, if any.
  final List<String>? errs;

  /// A list of warnings, if any.
  final List<String>? warning;

  /// The size of the quote currency.
  final Decimal? quoteSize;

  /// The size of the base currency.
  final Decimal? baseSize;

  /// The best bid price.
  final Decimal? bestBid;

  /// The best ask price.
  final Decimal? bestAsk;

  /// Whether the order is a max order.
  final bool? isMax;

  /// The total margin for the order.
  final Decimal? orderMarginTotal;

  /// The leverage for the order.
  final Decimal? leverage;

  /// The long leverage for the order.
  final Decimal? longLeverage;

  /// The short leverage for the order.
  final Decimal? shortLeverage;

  /// The slippage for the order.
  final Decimal? slippage;

  /// The ID of the preview.
  final String? previewId;

  /// The current liquidation buffer.
  final Decimal? currentLiquidationBuffer;

  /// The projected liquidation buffer.
  final Decimal? projectedLiquidationBuffer;

  /// The maximum leverage for the order.
  final Decimal? maxLeverage;

  /// The estimated average filled price.
  final Decimal? estAverageFilledPrice;

  /// The constructor for the [PreviewOrderResponse] class.
  PreviewOrderResponse({
    this.orderTotal,
    this.commissionTotal,
    this.errs,
    this.warning,
    this.quoteSize,
    this.baseSize,
    this.bestBid,
    this.bestAsk,
    this.isMax,
    this.orderMarginTotal,
    this.leverage,
    this.longLeverage,
    this.shortLeverage,
    this.slippage,
    this.previewId,
    this.currentLiquidationBuffer,
    this.projectedLiquidationBuffer,
    this.maxLeverage,
    this.estAverageFilledPrice,
  });

  /// Creates a [PreviewOrderResponse] from a JSON object.
  factory PreviewOrderResponse.fromCBJson(Map<String, dynamic> json) {
    return PreviewOrderResponse(
      orderTotal: nullableDecimal(json, 'order_total'),
      commissionTotal: nullableDecimal(json, 'commission_total'),
      errs: json['errs']?.cast<String>(),
      warning: json['warning']?.cast<String>(),
      quoteSize: nullableDecimal(json, 'quote_size'),
      baseSize: nullableDecimal(json, 'base_size'),
      bestBid: nullableDecimal(json, 'best_bid'),
      bestAsk: nullableDecimal(json, 'best_ask'),
      isMax: json['is_max'],
      orderMarginTotal: nullableDecimal(json, 'order_margin_total'),
      leverage: nullableDecimal(json, 'leverage'),
      longLeverage: nullableDecimal(json, 'long_leverage'),
      shortLeverage: nullableDecimal(json, 'short_leverage'),
      slippage: nullableDecimal(json, 'slippage'),
      previewId: json['preview_id'],
      currentLiquidationBuffer:
          nullableDecimal(json, 'current_liquidation_buffer'),
      projectedLiquidationBuffer:
          nullableDecimal(json, 'projected_liquidation_buffer'),
      maxLeverage: nullableDecimal(json, 'max_leverage'),
      estAverageFilledPrice: nullableDecimal(json, 'est_average_filled_price'),
    );
  }

  @override
  String toString() {
    return '''PreviewOrderResponse{
      orderTotal: $orderTotal,
      commissionTotal: $commissionTotal,
      errs: $errs,
      warning: $warning,
      quoteSize: $quoteSize,
      baseSize: $baseSize,
      bestBid: $bestBid,
      bestAsk: $bestAsk,
      isMax: $isMax,
      orderMarginTotal: $orderMarginTotal,
      leverage: $leverage,
      longLeverage: $longLeverage,
      shortLeverage: $shortLeverage,
      slippage: $slippage,
      previewId: $previewId,
      currentLiquidationBuffer: $currentLiquidationBuffer,
      projectedLiquidationBuffer: $projectedLiquidationBuffer,
      maxLeverage: $maxLeverage,
      estAverageFilledPrice: $estAverageFilledPrice
    }''';
  }
}
