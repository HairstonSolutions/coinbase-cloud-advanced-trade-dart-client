class CFMFuturesPosition {
  final String? productId;
  final String? expirationTime;
  final String? side;
  final String? numberOfContracts;
  final String? currentPrice;
  final String? avgEntryPrice;
  final String? unrealizedPnl;
  final String? dailyRealizedPnl;

  CFMFuturesPosition({
    this.productId,
    this.expirationTime,
    this.side,
    this.numberOfContracts,
    this.currentPrice,
    this.avgEntryPrice,
    this.unrealizedPnl,
    this.dailyRealizedPnl,
  });

  factory CFMFuturesPosition.fromCBJson(Map<String, dynamic> json) {
    return CFMFuturesPosition(
      productId: json['product_id'],
      expirationTime: json['expiration_time'],
      side: json['side'],
      numberOfContracts: json['number_of_contracts'],
      currentPrice: json['current_price'],
      avgEntryPrice: json['avg_entry_price'],
      unrealizedPnl: json['unrealized_pnl'],
      dailyRealizedPnl: json['daily_realized_pnl'],
    );
  }

  @override
  String toString() {
    return 'CFMFuturesPosition{productId: $productId, expirationTime: $expirationTime, side: $side, numberOfContracts: $numberOfContracts, currentPrice: $currentPrice, avgEntryPrice: $avgEntryPrice, unrealizedPnl: $unrealizedPnl, dailyRealizedPnl: $dailyRealizedPnl}';
  }
}
