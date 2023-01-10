import 'package:coinbase_cloud_advanced_trade_client/src/shared/services/tools.dart';

class Order {
  final String? id; // uuid
  final String? clientOid; // client order id
  final String? profileId; // profile_id that placed the order
  final String? productId; // book the order was placed on
  final String? side; // buy or sell
  final double? price; // price per unit of base currency
  final double? size; // amount of base currency to buy/sell
  final double? funds; // amount of quote currency to spend (for market orders)
  final double? specifiedFunds; // funds with fees
  final String? type; // limit market stop
  final String? timeInForce; // GTC GTT IOC FOK
  final bool? postOnly; // if true, forces order to be maker only
  final DateTime? createdAt; // timestamp at which order was placed
  final DateTime? expireTime; // timestamp at which order expires
  final DateTime? doneAt; // timestamp at which order was done
  final String?
      doneReason; // reason order was done (filled, rejected, or otherwise)
  final String? rejectReason; // reason order was rejected by engine
  final double? fillFees; // fees paid on current filled amount
  final double?
      filledSize; // amount (in base currency) of the order that has been filled
  final double? executedValue; // open pending rejected done active received all
  final String? status; // open pending rejected done active received all
  final bool? settled; // true if funds have been exchanged and settled
  final String? stop; // loss entry
  final double?
      stopPrice; // price (in quote currency) at which to execute the order

  Order(
      this.id,
      this.clientOid,
      this.profileId,
      this.productId,
      this.side,
      this.price,
      this.size,
      this.funds,
      this.specifiedFunds,
      this.type,
      this.timeInForce,
      this.postOnly,
      this.createdAt,
      this.expireTime,
      this.doneAt,
      this.doneReason,
      this.rejectReason,
      this.fillFees,
      this.filledSize,
      this.executedValue,
      this.status,
      this.settled,
      this.stop,
      this.stopPrice);

  Order.fromCBJson(Map<String, dynamic> json)
      : id = json['id'],
        clientOid = json['client_oid'],
        profileId = json['profile_id'],
        productId = json['product_id'],
        side = json['side'],
        price = nullableDouble(json, 'price'),
        size = nullableDouble(json, 'size'),
        funds = nullableDouble(json, 'funds'),
        specifiedFunds = nullableDouble(json, 'specified_funds'),
        type = json['type'],
        timeInForce = json['time_in_force'],
        postOnly = json['post_only'],
        createdAt = DateTime.parse(json['created_at']),
        expireTime = (json['expire_time'] != null)
            ? DateTime.parse(json['expire_time'])
            : null,
        doneAt =
            (json['done_at'] != null) ? DateTime.parse(json['done_at']) : null,
        doneReason = json['done_reason'],
        rejectReason = json['reject_reason'],
        fillFees = double.parse(json['fill_fees']),
        filledSize = double.parse(json['filled_size']),
        executedValue = double.parse(json['executed_value']),
        status = json['status'],
        settled = json['settled'],
        stop = json['stop'],
        stopPrice = nullableDouble(json, 'stop_price');

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        clientOid = json['clientOid'],
        profileId = json['profileId'],
        productId = json['productId'],
        side = json['side'],
        price = json['price'],
        size = json['size'],
        funds = json['funds'],
        specifiedFunds = json['specifiedFunds'],
        type = json['type'],
        timeInForce = json['timeInForce'],
        postOnly = json['postOnly'],
        createdAt = DateTime.parse(json['createdAt']),
        expireTime = (json['expireTime'] != null)
            ? DateTime.parse(json['expireTime'])
            : null,
        doneAt =
            (json['doneAt'] != null) ? DateTime.parse(json['doneAt']) : null,
        doneReason = json['doneReason'],
        rejectReason = json['rejectReason'],
        fillFees = json['fillFees'],
        filledSize = json['filledSize'],
        executedValue = json['executedValue'],
        status = json['status'],
        settled = json['settled'],
        stop = json['stop'],
        stopPrice = json['stopPrice'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientOid': clientOid,
        'profileId': profileId,
        'productId': productId,
        'side': side,
        'price': price,
        'size': size,
        'funds': funds,
        'specifiedFunds': specifiedFunds,
        'type': type,
        'timeInForce': timeInForce,
        'postOnly': postOnly,
        'createdAt': createdAt?.toIso8601String(),
        'expireTime': expireTime?.toIso8601String(),
        'doneAt': doneAt?.toIso8601String(),
        'doneReason': doneReason,
        'rejectReason': rejectReason,
        'fillFees': fillFees,
        'filledSize': filledSize,
        'executedValue': executedValue,
        'status': status,
        'settled': settled,
        'stop': stop,
        'stopPrice': stopPrice
      };

  @override
  String toString() {
    String all = '{id=$id, clientOid=$clientOid, profileId=$profileId, '
        'productId=$productId, side=$side, price=$price, size=$size, '
        'funds=$funds, specifiedFunds=$specifiedFunds, type=$type, '
        'timeInForce=$timeInForce, postOnly=$postOnly, createdAt=$createdAt, '
        'expireTime=$expireTime, doneAt=$doneAt, doneReason=$doneReason, '
        'rejectReason=$rejectReason, fillFees=$fillFees, '
        'filledSize=$filledSize, executedValue=$executedValue, status=$status, '
        'settled=$settled, stop=$stop'
        '}';
    return all;
  }
}
