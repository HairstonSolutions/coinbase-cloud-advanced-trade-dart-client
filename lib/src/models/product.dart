import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A representation of a product.
class Product {
  /// The product ID.
  final String? productId;

  /// The price of the product.
  final Decimal? price;

  /// The percentage change in price over the last 24 hours.
  final String? pricePercentageChange24h;

  /// The volume over the last 24 hours.
  final Decimal? volume24h;

  /// The percentage change in volume over the last 24 hours.
  final String? volumePercentageChange24h;

  /// The base increment.
  final Decimal? baseIncrement;

  /// The quote increment.
  final Decimal? quoteIncrement;

  /// The minimum quote size.
  final Decimal? quoteMinSize;

  /// The maximum quote size.
  final Decimal? quoteMaxSize;

  /// The minimum base size.
  final Decimal? baseMinSize;

  /// The maximum base size.
  final Decimal? baseMaxSize;

  /// The base name.
  final String? baseName;

  /// The quote name.
  final String? quoteName;

  /// Whether the product is watched.
  final bool? watched;

  /// Whether the product is disabled.
  final bool? isDisabled;

  /// Whether the product is new.
  final bool? isNew;

  /// The status of the product.
  final String? status;

  /// Whether the product is cancel-only.
  final bool? cancelOnly;

  /// Whether the product is limit-only.
  final bool? limitOnly;

  /// Whether the product is post-only.
  final bool? postOnly;

  /// Whether trading is disabled for the product.
  final bool? tradingDisabled;

  /// Whether the product is in auction mode.
  final bool? auctionMode;

  /// The type of the product.
  final String? productType;

  /// The quote currency ID.
  final String? quoteCurrencyId;

  /// The base currency ID.
  final String? baseCurrencyId;

  /// The FCM trading session details.
  final Map<String, dynamic>? fcmTradingSessionDetails;

  /// The mid-market price.
  final Decimal? midMarketPrice;

  /// The alias for the product.
  final String? alias;

  /// The aliases for the product.
  final List<String>? aliasTo;

  /// The base display symbol.
  final String? baseDisplaySymbol;

  /// The quote display symbol.
  final String? quoteDisplaySymbol;

  /// Whether the product is view-only.
  final bool? viewOnly;

  /// The price increment.
  final Decimal? priceIncrement;

  /// The display name.
  final String? displayName;

  /// The product venue.
  final String? productVenue;

  /// The approximate quote volume over the last 24 hours.
  final Decimal? approximateQuote24hVolume;

  /// The time the product was created.
  final DateTime? newAt;

  /// The market cap.
  final Decimal? marketCap;

  /// The future product details.
  final Map<String, dynamic>? futureProductDetails;

  /// The prediction market product details.
  final Map<String, dynamic>? predictionMarketProductDetails;

  /// Product constructor
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

  /// Creates a Product from a Coinbase JSON object.
  Product.fromCBJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        price = nullableDecimal(json, 'price'),
        pricePercentageChange24h = json['price_percentage_change_24h'],
        volume24h = nullableDecimal(json, 'volume_24h'),
        volumePercentageChange24h = json['volume_percentage_change_24h'],
        baseIncrement = nullableDecimal(json, 'base_increment'),
        quoteIncrement = nullableDecimal(json, 'quote_increment'),
        quoteMinSize = nullableDecimal(json, 'quote_min_size'),
        quoteMaxSize = nullableDecimal(json, 'quote_max_size'),
        baseMinSize = nullableDecimal(json, 'base_min_size'),
        baseMaxSize = nullableDecimal(json, 'base_max_size'),
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
        midMarketPrice = nullableDecimal(json, 'mid_market_price'),
        alias = json['alias'],
        aliasTo = List<String>.from(json['alias_to'] ?? []),
        baseDisplaySymbol = json['base_display_symbol'],
        quoteDisplaySymbol = json['quote_display_symbol'],
        viewOnly = json['view_only'],
        priceIncrement = nullableDecimal(json, 'price_increment'),
        displayName = json['display_name'],
        productVenue = json['product_venue'],
        approximateQuote24hVolume =
            nullableDecimal(json, 'approximate_quote_24h_volume'),
        newAt = DateTime.tryParse(json['new_at'] ?? ''),
        marketCap = nullableDecimal(json, 'market_cap'),
        futureProductDetails = json['future_product_details'],
        predictionMarketProductDetails =
            json['prediction_market_product_details'];

  /// Creates a Product from a JSON object.
  Product.fromJson(Map<String, dynamic> json)
      : productId = json['productId'],
        price = nullableDecimal(json, 'price'),
        pricePercentageChange24h = json['pricePercentageChange24h'],
        volume24h = nullableDecimal(json, 'volume24h'),
        volumePercentageChange24h = json['volumePercentageChange24h'],
        baseIncrement = nullableDecimal(json, 'baseIncrement'),
        quoteIncrement = nullableDecimal(json, 'quoteIncrement'),
        quoteMinSize = nullableDecimal(json, 'quoteMinSize'),
        quoteMaxSize = nullableDecimal(json, 'quoteMaxSize'),
        baseMinSize = nullableDecimal(json, 'baseMinSize'),
        baseMaxSize = nullableDecimal(json, 'baseMaxSize'),
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
        midMarketPrice = nullableDecimal(json, 'midMarketPrice'),
        alias = json['alias'],
        aliasTo = List<String>.from(json['aliasTo'] ?? []),
        baseDisplaySymbol = json['baseDisplaySymbol'],
        quoteDisplaySymbol = json['quoteDisplaySymbol'],
        viewOnly = json['viewOnly'],
        priceIncrement = nullableDecimal(json, 'priceIncrement'),
        displayName = json['displayName'],
        productVenue = json['productVenue'],
        approximateQuote24hVolume =
            nullableDecimal(json, 'approximateQuote24hVolume'),
        newAt = DateTime.tryParse(json['newAt'] ?? ''),
        marketCap = nullableDecimal(json, 'marketCap'),
        futureProductDetails = json['futureProductDetails'],
        predictionMarketProductDetails = json['predictionMarketProductDetails'];

  /// Converts a Product to a JSON object.
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'price': price?.toString(),
        'pricePercentageChange24h': pricePercentageChange24h,
        'volume24h': volume24h?.toString(),
        'volumePercentageChange24h': volumePercentageChange24h,
        'baseIncrement': baseIncrement?.toString(),
        'quoteIncrement': quoteIncrement?.toString(),
        'quoteMinSize': quoteMinSize?.toString(),
        'quoteMaxSize': quoteMaxSize?.toString(),
        'baseMinSize': baseMinSize?.toString(),
        'baseMaxSize': baseMaxSize?.toString(),
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
        'midMarketPrice': midMarketPrice?.toString(),
        'alias': alias,
        'aliasTo': aliasTo,
        'baseDisplaySymbol': baseDisplaySymbol,
        'quoteDisplaySymbol': quoteDisplaySymbol,
        'viewOnly': viewOnly,
        'priceIncrement': priceIncrement?.toString(),
        'displayName': displayName,
        'productVenue': productVenue,
        'approximateQuote24hVolume': approximateQuote24hVolume?.toString(),
        'newAt': newAt?.toIso8601String(),
        'marketCap': marketCap?.toString(),
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
