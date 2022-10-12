class Ticker {
  final double? ask;
  final double? bid;
  final double? volume;
  final int? tradeId;
  final double? price;
  final double? size;
  final String? time;

  Ticker(this.ask, this.bid, this.volume, this.tradeId, this.price, this.size,
      this.time);

  @override
  String toString() {
    String all = '{ask=$ask, bid=$bid, volume=$volume, tradeId=$tradeId, '
        'price=$price, size=$size, time=$time}';
    return all;
  }

  static Ticker convertJson(var jsonObject) {
    double? ask = double.parse(jsonObject['ask']);
    double? bid = double.parse(jsonObject['bid']);
    double? volume = double.parse(jsonObject['volume']);
    int? tradeId = jsonObject['trade_id'];
    double? price = double.parse(jsonObject['price']);
    double? size = double.parse(jsonObject['size']);
    String? time = jsonObject['time'];

    return Ticker(ask, bid, volume, tradeId, price, size, time);
  }
}

/*
Example Ticker: (Ticker = 'BTC-USD')
{
  "ask": "19575.87",
  "bid": "19575.86",
  "volume": "32583.29818082",
  "trade_id": 421548655,
  "price": "19575.86",
  "size": "0.46866237",
  "time": "2022-09-30T07:29:51.330954Z"
}
 */
