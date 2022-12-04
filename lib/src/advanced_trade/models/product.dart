class Product {
  final String? productId;
  final double? price;
  final String? pricePercentageChange24h;
  final double? volume24h;
  final String? volumePercentageChange24h;
  final double? baseIncrement;
  final double? quoteIncrement;
  final double? quoteMinSize;
  final double? quoteMaxSize;
  final double? baseMinSize;
  final double? baseMaxSize;
  final String? baseName;
  final String? quoteName;
  final bool? watched;
  final bool? isDisabled;
  final bool? isNew;
  final String? status;
  final bool? cancelOnly;
  final bool? limitOnly;
  final bool? postOnly;
  final bool? tradingDisabled;
  final bool? auctionMode;
  final String? productType;
  final String? quoteCurrencyId;
  final String? baseCurrencyId;
  final double? midMarketPrice;

  Product(
      this.productId,
      this.price,
      this.pricePercentageChange24h,
      this.volume24h,
      this.volumePercentageChange24h,
      this.baseIncrement,
      this.quoteIncrement,
      this.quoteMinSize,
      this.quoteMaxSize,
      this.baseMinSize,
      this.baseMaxSize,
      this.baseName,
      this.quoteName,
      this.watched,
      this.isDisabled,
      this.isNew,
      this.status,
      this.cancelOnly,
      this.limitOnly,
      this.postOnly,
      this.tradingDisabled,
      this.auctionMode,
      this.productType,
      this.quoteCurrencyId,
      this.baseCurrencyId,
      this.midMarketPrice);

  @override
  String toString() {
    String all = '{'
        'productId=$productId, price=$price, '
        'pricePercentageChange24h=$pricePercentageChange24h, '
        'volume24h=$volume24h, '
        'volumePercentageChange24h=$volumePercentageChange24h, '
        'baseIncrement=$baseIncrement, quoteIncrement=$quoteIncrement, '
        'quoteMinSize=$quoteMinSize, quoteMaxSize=$quoteMaxSize, '
        'baseMinSize=$baseMinSize, baseMaxSize=$baseMaxSize, '
        'baseName=$baseName, quoteName=$quoteName, watched=$watched, '
        'isDisabled=$isDisabled, isNew=$isNew, status=$status, '
        'cancelOnly=$cancelOnly, limitOnly=$limitOnly, postOnly=$postOnly, '
        'tradingDisabled=$tradingDisabled, auctionMode=$auctionMode, '
        'productType=$productType, quoteCurrencyId=$quoteCurrencyId, '
        'baseCurrencyId=$baseCurrencyId, midMarketPrice=$midMarketPrice'
        '}';
    return all;
  }

  static Product convertJson(var jsonObject) {
    String? productId = jsonObject['product_id'];
    double? price = double.parse(jsonObject['price']);
    String? pricePercentageChange24h =
        jsonObject['price_percentage_change_24h'];
    double? volume24h = double.parse(jsonObject['volume_24h']);
    String? volumePercentageChange24h =
        jsonObject['volume_percentage_change_24h'];
    double? baseIncrement = double.parse(jsonObject['base_increment']);
    double? quoteIncrement = double.parse(jsonObject['quote_increment']);
    double? quoteMinSize = double.parse(jsonObject['quote_min_size']);
    double? quoteMaxSize = double.parse(jsonObject['quote_max_size']);
    double? baseMinSize = double.parse(jsonObject['base_min_size']);
    double? baseMaxSize = double.parse(jsonObject['base_max_size']);
    String? baseName = jsonObject['base_name'];
    String? quoteName = jsonObject['quote_name'];
    bool? watched = jsonObject['watched'];
    bool? isDisabled = jsonObject['is_disabled'];
    bool? isNew = jsonObject['new'];
    String? status = jsonObject['status'];
    bool? cancelOnly = jsonObject['cancel_only'];
    bool? limitOnly = jsonObject['limit_only'];
    bool? postOnly = jsonObject['post_only'];
    bool? tradingDisabled = jsonObject['trading_disabled'];
    bool? auctionMode = jsonObject['auction_mode'];
    String? productType = jsonObject['product_type'];
    String? quoteCurrencyId = jsonObject['quote_currency_id'];
    String? baseCurrencyId = jsonObject['base_currency_id'];
    double? midMarketPrice = double.parse(jsonObject['mid_market_price']);

    return Product(
        productId,
        price,
        pricePercentageChange24h,
        volume24h,
        volumePercentageChange24h,
        baseIncrement,
        quoteIncrement,
        quoteMinSize,
        quoteMaxSize,
        baseMinSize,
        baseMaxSize,
        baseName,
        quoteName,
        watched,
        isDisabled,
        isNew,
        status,
        cancelOnly,
        limitOnly,
        postOnly,
        tradingDisabled,
        auctionMode,
        productType,
        quoteCurrencyId,
        baseCurrencyId,
        midMarketPrice);
  }
}
