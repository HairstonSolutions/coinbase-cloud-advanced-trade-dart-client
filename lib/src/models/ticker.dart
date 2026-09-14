import 'package:coinbase_cloud_advanced_trade_client/src/models/trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A representation of a ticker.
class Ticker {
  /// The trades for the ticker.
  final List<Trade>? trades;

  /// The best bid for the ticker.
  final Decimal? bestBid;

  /// The best ask for the ticker.
  final Decimal? bestAsk;

  /// Ticker constructor
  Ticker(this.trades, this.bestBid, this.bestAsk);

  /// Creates a Ticker from a Coinbase JSON object.
  Ticker.fromCBJson(Map<String, dynamic> json)
      : trades = (json['trades'] as List<dynamic>?)
            ?.map((trade) => Trade.fromCBJson(trade as Map<String, dynamic>))
            .toList(),
        bestBid = nullableDecimal(json, 'best_bid'),
        bestAsk = nullableDecimal(json, 'best_ask');

  @override
  String toString() =>
      'Ticker{trades: $trades, bestBid: $bestBid, bestAsk: $bestAsk}';
}
