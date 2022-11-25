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

  static Product convertJson(var jsonObject) {
    String id = jsonObject['id'];
    String? baseCurrency = jsonObject['base_currency'];
    String? quoteCurrency = jsonObject['quote_currency'];
    double? quoteIncrement = double.parse(jsonObject['quote_increment']);
    double? baseIncrement = double.parse(jsonObject['base_increment']);
    String? displayName = jsonObject['display_name'];
    double? minMarketFunds = double.parse(jsonObject['min_market_funds']);
    bool marginEnabled = jsonObject['margin_enabled'];
    bool postOnly = jsonObject['post_only'];
    bool limitOnly = jsonObject['limit_only'];
    bool cancelOnly = jsonObject['cancel_only'];
    String? status = jsonObject['status'];
    String? statusMessage = jsonObject['status_message'];
    bool tradingDisabled = jsonObject['trading_disabled'];
    bool fxStablecoin = jsonObject['fx_stablecoin'];
    double? maxSlippagePercentage =
        double.parse(jsonObject['max_slippage_percentage']);
    bool auctionMode = jsonObject['auction_mode'];

    return Product(
        id,
        baseCurrency,
        quoteCurrency,
        quoteIncrement,
        baseIncrement,
        displayName,
        minMarketFunds,
        marginEnabled,
        postOnly,
        limitOnly,
        cancelOnly,
        status,
        statusMessage,
        tradingDisabled,
        fxStablecoin,
        maxSlippagePercentage,
        auctionMode);
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
