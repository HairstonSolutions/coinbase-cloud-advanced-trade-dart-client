class Fill {
  final int? tradeId;
  final String? createdAt;
  final String? productId;
  final String? orderId;
  final String? userId;
  final String? profileId;
  final String? liquidity;
  final double? price;
  final double? size;
  final double? fee;
  final String? side;
  final bool settled;
  final double? usdVolume;

  Fill(
      this.tradeId,
      this.createdAt,
      this.productId,
      this.orderId,
      this.userId,
      this.profileId,
      this.liquidity,
      this.price,
      this.size,
      this.fee,
      this.side,
      this.settled,
      this.usdVolume);

  @override
  String toString() {
    String all = '{tradeId=$tradeId, createdAt=$createdAt, '
        'productId=$productId, orderId=$orderId, userId=$userId, '
        'profileId=$profileId, liquidity=$liquidity, price=$price, size=$size, '
        'fee=$fee, side=$side, settled=$settled, usdVolume=$usdVolume'
        '}';
    return all;
  }

  static Fill convertJson(var jsonObject) {
    int? tradeId = jsonObject['trade_id'];
    String? createdAt = jsonObject['created_at'];
    String? productId = jsonObject['product_id'];
    String? orderId = jsonObject['order_id'];
    String? userId = jsonObject['user_id'];
    String? profileId = jsonObject['profile_id'];
    String? liquidity = jsonObject['liquidity'];
    double? price = double.parse(jsonObject['price']);
    double? size = double.parse(jsonObject['size']);
    double? fee = double.parse(jsonObject['fee']);
    String? side = jsonObject['side'];
    bool settled = jsonObject['settled'];
    double? usdVolume = double.parse(jsonObject['usd_volume']);

    return Fill(tradeId, createdAt, productId, orderId, userId, profileId,
        liquidity, price, size, fee, side, settled, usdVolume);
  }
}

/*
EXAMPLE Fill: "BTC-USD"
{
  "created_at": "2021-12-24T17:01:00.300546Z",
  "trade_id": 36916683,
  "product_id": "BTC-USD",
  "order_id": "200d07ba-e12b-494b-9a97-07fb0a94a95f",
  "user_id": "61b2242f9ad43702b15c816e",
  "profile_id": "c1173eaa-6451-4a0e-9c3a-334076c8a44d",
  "liquidity": "M",
  "price": "99.98000000",
  "size": "8.00000000",
  "fee": "3.9992000000000000",
  "side": "buy",
  "settled": true,
  "usd_volume": "799.8400000000000000"
}
 */
