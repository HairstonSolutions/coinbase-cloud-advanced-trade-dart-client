import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

/// The response from a preview order request.
class PreviewOrderResponse {
  /// The total cost of the order.
  final String? orderTotal;

  /// The total commission for the order.
  final String? commissionTotal;

  /// A list of errors, if any.
  final List<String>? errs;

  /// A list of warnings, if any.
  final List<String>? warning;

  /// The size of the quote currency.
  final double? quoteSize;

  /// The size of the base currency.
  final double? baseSize;

  /// The best bid price.
  final String? bestBid;

  /// The best ask price.
  final String? bestAsk;

  /// Whether the order is a max order.
  final bool? isMax;

  /// The total margin for the order.
  final String? orderMarginTotal;

  /// The leverage for the order.
  final String? leverage;

  /// The long leverage for the order.
  final String? longLeverage;

  /// The short leverage for the order.
  final String? shortLeverage;

  /// The slippage for the order.
  final String? slippage;

  /// The ID of the preview.
  final String? previewId;

  /// The current liquidation buffer.
  final String? currentLiquidationBuffer;

  /// The projected liquidation buffer.
  final String? projectedLiquidationBuffer;

  /// The maximum leverage for the order.
  final String? maxLeverage;

  /// The estimated average filled price.
  final String? estAverageFilledPrice;

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
      orderTotal: json['order_total'],
      commissionTotal: json['commission_total'],
      errs: json['errs']?.cast<String>(),
      warning: json['warning']?.cast<String>(),
      quoteSize: nullableDouble(json, 'quote_size'),
      baseSize: nullableDouble(json, 'base_size'),
      bestBid: json['best_bid'],
      bestAsk: json['best_ask'],
      isMax: json['is_max'],
      orderMarginTotal: json['order_margin_total'],
      leverage: json['leverage'],
      longLeverage: json['long_leverage'],
      shortLeverage: json['short_leverage'],
      slippage: json['slippage'],
      previewId: json['preview_id'],
      currentLiquidationBuffer: json['current_liquidation_buffer'],
      projectedLiquidationBuffer: json['projected_liquidation_buffer'],
      maxLeverage: json['max_leverage'],
      estAverageFilledPrice: json['est_average_filled_price'],
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
