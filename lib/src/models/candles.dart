import 'package:coinbase_cloud_advanced_trade_client/src/models/candle.dart';

class Candles {
  final List<Candle> candles;

  Candles(this.candles);

  factory Candles.fromCBJson(Map<String, dynamic> json) {
    var candles = <Candle>[];
    for (var candle in json['candles']) {
      candles.add(Candle.fromCBJson(candle));
    }

    return Candles(candles);
  }
}
