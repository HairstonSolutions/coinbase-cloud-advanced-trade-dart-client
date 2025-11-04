import 'package:coinbase_cloud_advanced_trade_client/src/models/public_order_book_entry.dart';

class PublicPriceBook {
  final String productId;
  final List<PublicOrderBookEntry> bids;
  final List<PublicOrderBookEntry> asks;
  final String time;

  PublicPriceBook(this.productId, this.bids, this.asks, this.time);

  factory PublicPriceBook.fromCBJson(Map<String, dynamic> json) {
    var bids = <PublicOrderBookEntry>[];
    for (var entry in json['bids']) {
      bids.add(PublicOrderBookEntry.fromCBJson(entry));
    }

    var asks = <PublicOrderBookEntry>[];
    for (var entry in json['asks']) {
      asks.add(PublicOrderBookEntry.fromCBJson(entry));
    }

    return PublicPriceBook(
      json['product_id'],
      bids,
      asks,
      json['time'],
    );
  }
}
