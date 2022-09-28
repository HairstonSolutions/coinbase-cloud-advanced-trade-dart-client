class Product {
  final String? id;
  final String? baseCurrency;
  final String? quoteCurrency;
  final double? quoteIncrement;
  final double? baseIncrement;
  final String? displayName;
  final double? minMarketFunds;
  final bool marginEnabled;
  final bool postOnly;
  final bool limitOnly;
  final bool cancelOnly;
  final String? status;
  final String? statusMessage;
  final bool tradingDisabled;
  final bool fxStablecoin;
  final double? maxSlippagePercentage;
  final bool auctionMode;

  Product(
      this.id,
      this.baseCurrency,
      this.quoteCurrency,
      this.quoteIncrement,
      this.baseIncrement,
      this.displayName,
      this.minMarketFunds,
      this.marginEnabled,
      this.postOnly,
      this.limitOnly,
      this.cancelOnly,
      this.status,
      this.statusMessage,
      this.tradingDisabled,
      this.fxStablecoin,
      this.maxSlippagePercentage,
      this.auctionMode);

  @override
  String toString() {
    String all = '{id=$id, baseCurrency=$baseCurrency, '
        'quoteCurrency=$quoteCurrency, quoteIncrement=$quoteIncrement, '
        'baseIncrement=$baseIncrement, displayName=$displayName, '
        'minMarketFunds=$minMarketFunds, marginEnabled=$marginEnabled, '
        'postOnly=$postOnly, limitOnly=$limitOnly, cancelOnly=$cancelOnly, '
        'status=$status, statusMessage=$statusMessage, '
        'tradingDisabled=$tradingDisabled, fxStablecoin=$fxStablecoin, '
        'maxSlippagePercentage=$maxSlippagePercentage, '
        'auctionMode=$auctionMode}';
    return all;
  }
}

/*
EXAMPLE PRODUCT: "ADA-USD"
  {
    "id": "ADA-USD",
    "base_currency": "ADA",
    "quote_currency": "USD",
    "quote_increment": "0.0001",
    "base_increment": "0.01",
    "display_name": "ADA/USD",
    "min_market_funds": "1",
    "margin_enabled": false,
    "post_only": false,
    "limit_only": false,
    "cancel_only": false,
    "status": "online",
    "status_message": "",
    "trading_disabled": false,
    "fx_stablecoin": false,
    "max_slippage_percentage": "0.03000000",
    "auction_mode": false
  }
 */
