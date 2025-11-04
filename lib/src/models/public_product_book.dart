import 'package:coinbase_cloud_advanced_trade_client/src/models/public_price_book.dart';

class PublicProductBook {
  final PublicPriceBook pricebook;
  final String last;
  final String midMarket;
  final String spreadBps;
  final String spreadAbsolute;

  PublicProductBook(this.pricebook, this.last, this.midMarket, this.spreadBps,
      this.spreadAbsolute);

  factory PublicProductBook.fromCBJson(Map<String, dynamic> json) {
    return PublicProductBook(
      PublicPriceBook.fromCBJson(json['pricebook']),
      json['last'],
      json['mid_market'],
      json['spread_bps'],
      json['spread_absolute'],
    );
  }
}
