import 'package:coinbase_cloud_advanced_trade_client/src/shared/services/tools.dart';

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

  Product.fromCBJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        price = double.parse(json['price']),
        pricePercentageChange24h = json['price_percentage_change_24h'],
        volume24h = double.parse(json['volume_24h']),
        volumePercentageChange24h = json['volume_percentage_change_24h'],
        baseIncrement = double.parse(json['base_increment']),
        quoteIncrement = double.parse(json['quote_increment']),
        quoteMinSize = double.parse(json['quote_min_size']),
        quoteMaxSize = double.parse(json['quote_max_size']),
        baseMinSize = double.parse(json['base_min_size']),
        baseMaxSize = double.parse(json['base_max_size']),
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
        midMarketPrice = nullableDouble(json, 'mid_market_price');

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
        midMarketPrice = json['midMarketPrice'];

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
        'midMarketPrice': midMarketPrice
      };

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
}
