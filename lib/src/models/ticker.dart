import 'package:coinbase_cloud_advanced_trade_client/src/models/trade.dart';

class Ticker {
  final List<Trade> trades;
  final String bestBid;
  final String bestAsk;

  Ticker(this.trades, this.bestBid, this.bestAsk);

  factory Ticker.fromCBJson(Map<String, dynamic> json) {
    var trades = <Trade>[];
    for (var trade in json['trades']) {
      trades.add(Trade.fromCBJson(trade));
    }

    return Ticker(
      trades,
      json['best_bid'],
      json['best_ask'],
    );
  }
}
