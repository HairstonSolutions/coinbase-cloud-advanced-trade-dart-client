class FuturesPosition {
  final String productId;
  final String expirationTime;
  final String side;
  final String numberOfContracts;
  final String currentPrice;
  final String avgEntryPrice;
  final String unrealizedPnl;
  final String dailyRealizedPnl;

  FuturesPosition(
      {required this.productId,
      required this.expirationTime,
      required this.side,
      required this.numberOfContracts,
      required this.currentPrice,
      required this.avgEntryPrice,
      required this.unrealizedPnl,
      required this.dailyRealizedPnl});

  factory FuturesPosition.fromCBJson(Map<String, dynamic> json) {
    return FuturesPosition(
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
}
