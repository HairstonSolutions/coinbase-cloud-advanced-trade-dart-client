class PreviewOrderResponse {
  final String? orderTotal;
  final String? commissionTotal;
  final List<String>? errs;
  final List<String>? warning;
  final double? quoteSize;
  final double? baseSize;
  final String? bestBid;
  final String? bestAsk;
  final bool? isMax;
  final String? orderMarginTotal;
  final String? leverage;
  final String? longLeverage;
  final String? shortLeverage;
  final String? slippage;
  final String? previewId;
  final String? currentLiquidationBuffer;
  final String? projectedLiquidationBuffer;
  final String? maxLeverage;
  final String? estAverageFilledPrice;

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

  factory PreviewOrderResponse.fromCBJson(Map<String, dynamic> json) {
    return PreviewOrderResponse(
      orderTotal: json['order_total'],
      commissionTotal: json['commission_total'],
      errs: json['errs']?.cast<String>(),
      warning: json['warning']?.cast<String>(),
      quoteSize: double.tryParse(json['quote_size'] ?? ''),
      baseSize: double.tryParse(json['base_size'] ?? ''),
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
    return 'PreviewOrderResponse{orderTotal: $orderTotal, commissionTotal: $commissionTotal, errs: $errs, warning: $warning, quoteSize: $quoteSize, baseSize: $baseSize, bestBid: $bestBid, bestAsk: $bestAsk, isMax: $isMax, orderMarginTotal: $orderMarginTotal, leverage: $leverage, longLeverage: $longLeverage, shortLeverage: $shortLeverage, slippage: $slippage, previewId: $previewId, currentLiquidationBuffer: $currentLiquidationBuffer, projectedLiquidationBuffer: $projectedLiquidationBuffer, maxLeverage: $maxLeverage, estAverageFilledPrice: $estAverageFilledPrice}';
  }
}
