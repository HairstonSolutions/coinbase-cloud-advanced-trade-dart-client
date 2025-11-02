import 'package:coinbase_pro_sdk/src/services/tools.dart';

class Fill {
  final int? tradeId;
  final DateTime? createdAt;
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

  Fill.fromCBJson(Map<String, dynamic> json)
      : tradeId = json['trade_id'],
        createdAt = DateTime.parse(json['created_at']),
        productId = json['product_id'],
        orderId = json['order_id'],
        userId = json['user_id'],
        profileId = json['profile_id'],
        liquidity = json['liquidity'],
        price = double.parse(json['price']),
        size = double.parse(json['size']),
        fee = double.parse(json['fee']),
        side = json['side'],
        settled = json['settled'],
        usdVolume = nullableDouble(json, 'usd_volume');

  Fill.fromJson(Map<String, dynamic> json)
      : tradeId = json['tradeId'],
        createdAt = DateTime.parse(json['createdAt']),
        productId = json['productId'],
        orderId = json['orderId'],
        userId = json['userId'],
        profileId = json['profileId'],
        liquidity = json['liquidity'],
        price = json['price'],
        size = json['size'],
        fee = json['fee'],
        side = json['side'],
        settled = json['settled'],
        usdVolume = json['usdVolume'];

  Map<String, dynamic> toJson() => {
        'tradeId': tradeId,
        'createdAt': createdAt?.toIso8601String(),
        'productId': productId,
        'orderId': orderId,
        'userId': userId,
        'profileId': profileId,
        'liquidity': liquidity,
        'price': price,
        'size': size,
        'fee': fee,
        'side': side,
        'settled': settled,
        'usdVolume': usdVolume
      };

  @override
  String toString() {
    String all = '{tradeId=$tradeId, createdAt=$createdAt, '
        'productId=$productId, orderId=$orderId, userId=$userId, '
        'profileId=$profileId, liquidity=$liquidity, price=$price, size=$size, '
        'fee=$fee, side=$side, settled=$settled, usdVolume=$usdVolume'
        '}';
    return all;
  }
}
