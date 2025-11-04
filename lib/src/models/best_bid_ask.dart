import 'package:coinbase_cloud_advanced_trade_client/src/models/public_price_book.dart';

class BestBidAsk {
  final List<PublicPriceBook> pricebooks;

  BestBidAsk({required this.pricebooks});

  factory BestBidAsk.fromCBJson(Map<String, dynamic> json) {
    var pricebooks = <PublicPriceBook>[];
    for (var pricebook in json['pricebooks']) {
      pricebooks.add(PublicPriceBook.fromCBJson(pricebook));
    }

    return BestBidAsk(pricebooks: pricebooks);
  }
}
