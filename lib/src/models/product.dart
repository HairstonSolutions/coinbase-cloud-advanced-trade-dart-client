import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

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
  final Map<String, dynamic>? fcmTradingSessionDetails;
  final double? midMarketPrice;
  final String? alias;
  final List<String>? aliasTo;
  final String? baseDisplaySymbol;
  final String? quoteDisplaySymbol;
  final bool? viewOnly;
  final double? priceIncrement;
  final String? displayName;
  final String? productVenue;
  final double? approximateQuote24hVolume;
  final DateTime? newAt;
  final double? marketCap;
  final Map<String, dynamic>? futureProductDetails;
  final Map<String, dynamic>? predictionMarketProductDetails;

  Product({
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
    this.fcmTradingSessionDetails,
    this.midMarketPrice,
    this.alias,
    this.aliasTo,
    this.baseDisplaySymbol,
    this.quoteDisplaySymbol,
    this.viewOnly,
    this.priceIncrement,
    this.displayName,
    this.productVenue,
    this.approximateQuote24hVolume,
    this.newAt,
    this.marketCap,
    this.futureProductDetails,
    this.predictionMarketProductDetails,
  });

  Product.fromCBJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        price = double.tryParse(json['price'] ?? ''),
        pricePercentageChange24h = json['price_percentage_change_24h'],
        volume24h = double.tryParse(json['volume_24h'] ?? ''),
        volumePercentageChange24h = json['volume_percentage_change_24h'],
        baseIncrement = double.tryParse(json['base_increment'] ?? ''),
        quoteIncrement = double.tryParse(json['quote_increment'] ?? ''),
        quoteMinSize = double.tryParse(json['quote_min_size'] ?? ''),
        quoteMaxSize = double.tryParse(json['quote_max_size'] ?? ''),
        baseMinSize = double.tryParse(json['base_min_size'] ?? ''),
        baseMaxSize = double.tryParse(json['base_max_size'] ?? ''),
        baseName = json['base_name'],
        quoteName = json['quote_name'],
        watched = json['watched'],
        isDisabled = json['is_disabled'],
        isNew = json['new'],
        status = json['status'],
        cancelOnly = json['cancel_only'],
        limitOnly = json['limit_only'],
        postOnly = json['post_only'],
        tradingDisabled = json['trading_disabled'],
        auctionMode = json['auction_mode'],
        productType = json['product_type'],
        quoteCurrencyId = json['quote_currency_id'],
        baseCurrencyId = json['base_currency_id'],
        fcmTradingSessionDetails = json['fcm_trading_session_details'],
        midMarketPrice = nullableDouble(json, 'mid_market_price'),
        alias = json['alias'],
        aliasTo = List<String>.from(json['alias_to'] ?? []),
        baseDisplaySymbol = json['base_display_symbol'],
        quoteDisplaySymbol = json['quote_display_symbol'],
        viewOnly = json['view_only'],
        priceIncrement = double.tryParse(json['price_increment'] ?? ''),
        displayName = json['display_name'],
        productVenue = json['product_venue'],
        approximateQuote24hVolume =
            double.tryParse(json['approximate_quote_24h_volume'] ?? ''),
        newAt = DateTime.tryParse(json['new_at'] ?? ''),
        marketCap = double.tryParse(json['market_cap'] ?? ''),
        futureProductDetails = json['future_product_details'],
        predictionMarketProductDetails =
            json['prediction_market_product_details'];

  Product.fromJson(Map<String, dynamic> json)
      : productId = json['productId'],
        price = json['price'],
        pricePercentageChange24h = json['pricePercentageChange24h'],
        volume24h = json['volume24h'],
        volumePercentageChange24h = json['volumePercentageChange24h'],
        baseIncrement = json['baseIncrement'],
        quoteIncrement = json['quoteIncrement'],
        quoteMinSize = json['quoteMinSize'],
        quoteMaxSize = json['quoteMaxSize'],
        baseMinSize = json['baseMinSize'],
        baseMaxSize = json['baseMaxSize'],
        baseName = json['baseName'],
        quoteName = json['quoteName'],
        watched = json['watched'],
        isDisabled = json['isDisabled'],
        isNew = json['isNew'],
        status = json['status'],
        cancelOnly = json['cancelOnly'],
        limitOnly = json['limitOnly'],
        postOnly = json['postOnly'],
        tradingDisabled = json['tradingDisabled'],
        auctionMode = json['auctionMode'],
        productType = json['productType'],
        quoteCurrencyId = json['quoteCurrencyId'],
        baseCurrencyId = json['baseCurrencyId'],
        fcmTradingSessionDetails = json['fcmTradingSessionDetails'],
        midMarketPrice = json['midMarketPrice'],
        alias = json['alias'],
        aliasTo = List<String>.from(json['aliasTo'] ?? []),
        baseDisplaySymbol = json['baseDisplaySymbol'],
        quoteDisplaySymbol = json['quoteDisplaySymbol'],
        viewOnly = json['viewOnly'],
        priceIncrement = json['priceIncrement'],
        displayName = json['displayName'],
        productVenue = json['productVenue'],
        approximateQuote24hVolume = json['approximateQuote24hVolume'],
        newAt = DateTime.tryParse(json['newAt'] ?? ''),
        marketCap = json['marketCap'],
        futureProductDetails = json['futureProductDetails'],
        predictionMarketProductDetails = json['predictionMarketProductDetails'];

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'price': price,
        'pricePercentageChange24h': pricePercentageChange24h,
        'volume24h': volume24h,
        'volumePercentageChange24h': volumePercentageChange24h,
        'baseIncrement': baseIncrement,
        'quoteIncrement': quoteIncrement,
        'quoteMinSize': quoteMinSize,
        'quoteMaxSize': quoteMaxSize,
        'baseMinSize': baseMinSize,
        'baseMaxSize': baseMaxSize,
        'baseName': baseName,
        'quoteName': quoteName,
        'watched': watched,
        'isDisabled': isDisabled,
        'isNew': isNew,
        'status': status,
        'cancelOnly': cancelOnly,
        'limitOnly': limitOnly,
        'postOnly': postOnly,
        'tradingDisabled': tradingDisabled,
        'auctionMode': auctionMode,
        'productType': productType,
        'quoteCurrencyId': quoteCurrencyId,
        'baseCurrencyId': baseCurrencyId,
        'fcmTradingSessionDetails': fcmTradingSessionDetails,
        'midMarketPrice': midMarketPrice,
        'alias': alias,
        'aliasTo': aliasTo,
        'baseDisplaySymbol': baseDisplaySymbol,
        'quoteDisplaySymbol': quoteDisplaySymbol,
        'viewOnly': viewOnly,
        'priceIncrement': priceIncrement,
        'displayName': displayName,
        'productVenue': productVenue,
        'approximateQuote24hVolume': approximateQuote24hVolume,
        'newAt': newAt?.toIso8601String(),
        'marketCap': marketCap,
        'futureProductDetails': futureProductDetails,
        'predictionMarketProductDetails': predictionMarketProductDetails,
      };

  @override
  String toString() {
    return '{'
        'productId: $productId, '
        'price: $price, '
        'pricePercentageChange24h: $pricePercentageChange24h, '
        'volume24h: $volume24h, '
        'volumePercentageChange24h: $volumePercentageChange24h, '
        'baseIncrement: $baseIncrement, '
        'quoteIncrement: $quoteIncrement, '
        'quoteMinSize: $quoteMinSize, '
        'quoteMaxSize: $quoteMaxSize, '
        'baseMinSize: $baseMinSize, '
        'baseMaxSize: $baseMaxSize, '
        'baseName: $baseName, '
        'quoteName: $quoteName, '
        'watched: $watched, '
        'isDisabled: $isDisabled, '
        'isNew: $isNew, '
        'status: $status, '
        'cancelOnly: $cancelOnly, '
        'limitOnly: $limitOnly, '
        'postOnly: $postOnly, '
        'tradingDisabled: $tradingDisabled, '
        'auctionMode: $auctionMode, '
        'productType: $productType, '
        'quoteCurrencyId: $quoteCurrencyId, '
        'baseCurrencyId: $baseCurrencyId, '
        'fcmTradingSessionDetails: $fcmTradingSessionDetails, '
        'midMarketPrice: $midMarketPrice, '
        'alias: $alias, '
        'aliasTo: $aliasTo, '
        'baseDisplaySymbol: $baseDisplaySymbol, '
        'quoteDisplaySymbol: $quoteDisplaySymbol, '
        'viewOnly: $viewOnly, '
        'priceIncrement: $priceIncrement, '
        'displayName: $displayName, '
        'productVenue: $productVenue, '
        'approximateQuote24hVolume: $approximateQuote24hVolume, '
        'newAt: $newAt, '
        'marketCap: $marketCap, '
        'futureProductDetails: $futureProductDetails, '
        'predictionMarketProductDetails: $predictionMarketProductDetails'
        '}';
  }
}
