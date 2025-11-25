import 'package:coinbase_cloud_advanced_trade_client/src/models/trade.dart';

class Ticker {
  final List<Trade>? trades;
  final double? bestBid;
  final double? bestAsk;

  Ticker(this.trades, this.bestBid, this.bestAsk);

  Ticker.fromCBJson(Map<String, dynamic> json)
      : trades = (json['trades'] as List<dynamic>?)
            ?.map((trade) => Trade.fromCBJson(trade as Map<String, dynamic>))
            .toList(),
        bestBid = double.tryParse(json['best_bid'] ?? ''),
        bestAsk = double.tryParse(json['best_ask'] ?? '');

  @override
  String toString() =>
      'Ticker{trades: $trades, bestBid: $bestBid, bestAsk: $bestAsk}';
}
