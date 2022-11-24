import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

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
  final String? createdAt; // timestamp at which order was placed
  final String? expireTime; // timestamp at which order expires
  final String? doneAt; // timestamp at which order was done
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

  static Order convertJson(var jsonObject) {
    String? id = jsonObject['id'];
    String? clientOid = jsonObject['client_oid'];
    String? profileId = jsonObject['profile_id'];
    String? productId = jsonObject['product_id'];
    String? side = jsonObject['side'];
    double? price = nullableDouble(jsonObject, 'price');
    double? size = nullableDouble(jsonObject, 'size');
    double? funds = nullableDouble(jsonObject, 'funds');
    double? specifiedFunds = nullableDouble(jsonObject, 'specified_funds');
    String? type = jsonObject['type'];
    String? timeInForce = jsonObject['time_in_force'];
    bool? postOnly = jsonObject['post_only'];
    String? createdAt = jsonObject['created_at'];
    String? expireTime = jsonObject['expire_time'];
    String? doneAt = jsonObject['done_at'];
    String? doneReason = jsonObject['done_reason'];
    String? rejectReason = jsonObject['reject_reason'];
    double? fillFees = double.parse(jsonObject['fill_fees']);
    double? filledSize = double.parse(jsonObject['filled_size']);
    double? executedValue = double.parse(jsonObject['executed_value']);
    String? status = jsonObject['status'];
    bool? settled = jsonObject['settled'];
    String? stop = jsonObject['stop'];
    double? stopPrice = nullableDouble(jsonObject, 'stop_price');

    return Order(
        id,
        clientOid,
        profileId,
        productId,
        side,
        price,
        size,
        funds,
        specifiedFunds,
        type,
        timeInForce,
        postOnly,
        createdAt,
        expireTime,
        doneAt,
        doneReason,
        rejectReason,
        fillFees,
        filledSize,
        executedValue,
        status,
        settled,
        stop,
        stopPrice);
  }
}

/*
{
  id: 927700a7-8bb0-4d1b-97b0-05f1f6f75732,
  client_oid: 2b1f96e1-62a4-4d62-8367-62271851505d,
  product_id: LINK-USD,
  profile_id: c1173eaa-6451-4a0e-9c3a-334076c8a44d,
  side: buy,
  funds: 994.0300000000000000,
  specified_funds: 1000.0000000000000000,
  type: market,
  post_only: false,
  created_at: 2022-10-10T05:11:46.92006Z,
  done_at: 2022-10-10T05:11:46.92006Z,
  done_reason: canceled,
  fill_fees: 0.0000000000000000,
  filled_size: 0.00000000,
  executed_value: 0.0000000000000000,
  status: done,
  settled: true
}/n
 */
