import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_configuration.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_side.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_status.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_type.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/product_type.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/reject_reason.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/time_in_force.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/trigger_status.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// An order.
class Order {
  /// The order ID.
  final String? orderId;

  /// The product ID.
  final String? productId;

  /// The user ID.
  final String? userId;

  /// The order configuration.
  final OrderConfiguration? orderConfiguration;

  /// The side of the order.
  final OrderSide? side;

  /// The client order ID.
  final String? clientOrderId;

  /// The status of the order.
  final OrderStatus? status;

  /// The time in force for the order.
  final TimeInForce? timeInForce;

  /// The time the order was created.
  final DateTime? createdTime;

  /// The completion percentage of the order.
  final Decimal? completionPercentage;

  /// The filled size of the order.
  final Decimal? filledSize;

  /// The average filled price of the order.
  final Decimal? averageFilledPrice;

  /// The fee for the order.
  final Decimal? fee;

  /// The number of fills for the order.
  final int? numberOfFills;

  /// The filled value of the order.
  final Decimal? filledValue;

  /// Whether the order is pending cancellation.
  final bool? pendingCancel;

  /// Whether the size is in the quote currency.
  final bool? sizeInQuote;

  /// The total fees for the order.
  final Decimal? totalFees;

  /// Whether the size is inclusive of fees.
  final bool? sizeInclusiveOfFees;

  /// The total value after fees.
  final Decimal? totalValueAfterFees;

  /// The trigger status of the order.
  final TriggerStatus? triggerStatus;

  /// The type of the order.
  final OrderType? orderType;

  /// The reason the order was rejected.
  final RejectReason? rejectReason;

  /// Whether the order is settled.
  final bool? settled;

  /// The product type.
  final ProductType? productType;

  /// The reject message.
  final String? rejectMessage;

  /// The cancel message.
  final String? cancelMessage;

  /// Order constructor
  Order(
      this.orderId,
      this.productId,
      this.userId,
      this.orderConfiguration,
      this.side,
      this.clientOrderId,
      this.status,
      this.timeInForce,
      this.createdTime,
      this.completionPercentage,
      this.filledSize,
      this.averageFilledPrice,
      this.fee,
      this.numberOfFills,
      this.filledValue,
      this.pendingCancel,
      this.sizeInQuote,
      this.totalFees,
      this.sizeInclusiveOfFees,
      this.totalValueAfterFees,
      this.triggerStatus,
      this.orderType,
      this.rejectReason,
      this.settled,
      this.productType,
      this.rejectMessage,
      this.cancelMessage);

  /// Creates an Order from a JSON object.
  Order.fromJson(Map<String, dynamic> json)
      : orderId = json['orderId'],
        productId = json['productId'],
        userId = json['userId'],
        orderConfiguration = json['orderConfiguration'],
        side = OrderSide.fromCB(json['side']),
        clientOrderId = json['clientOrderId'],
        status = OrderStatus.fromCB(json['status']),
        timeInForce = TimeInForce.fromCB(json['timeInForce']),
        createdTime = DateTime.parse(json['createdTime']),
        completionPercentage = nullableDecimal(json, 'completionPercentage'),
        filledSize = nullableDecimal(json, 'filledSize'),
        averageFilledPrice = nullableDecimal(json, 'averageFilledPrice'),
        fee = nullableDecimal(json, 'fee'),
        numberOfFills = nullableInt(json, 'numberOfFills'),
        filledValue = nullableDecimal(json, 'filledValue'),
        pendingCancel = json['pendingCancel'],
        sizeInQuote = json['sizeInQuote'],
        totalFees = nullableDecimal(json, 'totalFees'),
        sizeInclusiveOfFees = json['sizeInclusiveOfFees'],
        totalValueAfterFees = nullableDecimal(json, 'totalValueAfterFees'),
        triggerStatus = TriggerStatus.fromCB(json['triggerStatus']),
        orderType = OrderType.fromCB(json['orderType']),
        rejectReason = RejectReason.fromCB(json['rejectReason']),
        settled = json['settled'],
        productType = ProductType.fromCB(json['productType']),
        rejectMessage = json['rejectMessage'],
        cancelMessage = json['cancelMessage'];

  /// Converts an Order to a JSON object.
  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'productId': productId,
        'userId': userId,
        'orderConfiguration': orderConfiguration,
        'side': side?.toCB(),
        'clientOrderId': clientOrderId,
        'status': status?.toCB(),
        'timeInForce': timeInForce?.toCB(),
        'createdTime': createdTime?.toIso8601String(),
        'completionPercentage': completionPercentage?.toString(),
        'filledSize': filledSize?.toString(),
        'averageFilledPrice': averageFilledPrice?.toString(),
        'fee': fee?.toString(),
        'numberOfFills': numberOfFills,
        'filledValue': filledValue?.toString(),
        'pendingCancel': pendingCancel,
        'sizeInQuote': sizeInQuote,
        'totalFees': totalFees?.toString(),
        'sizeInclusiveOfFees': sizeInclusiveOfFees,
        'totalValueAfterFees': totalValueAfterFees?.toString(),
        'triggerStatus': triggerStatus?.toCB(),
        'orderType': orderType?.toCB(),
        'rejectReason': rejectReason?.toCB(),
        'settled': settled,
        'productType': productType?.toCB(),
        'rejectMessage': rejectMessage,
        'cancelMessage': cancelMessage
      };

  /// Creates an Order from a Coinbase JSON object.
  Order.fromCBJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        productId = json['product_id'],
        userId = json['user_id'],
        orderConfiguration =
            OrderConfiguration.fromCBJson(json['order_configuration']),
        side = OrderSide.fromCB(json['side']),
        clientOrderId = json['client_order_id'],
        status = OrderStatus.fromCB(json['status']),
        timeInForce = TimeInForce.fromCB(json['time_in_force']),
        createdTime = DateTime.parse(json['created_time']),
        completionPercentage = nullableDecimal(json, 'completion_percentage'),
        filledSize = nullableDecimal(json, 'filled_size'),
        averageFilledPrice = nullableDecimal(json, 'average_filled_price'),
        fee = nullableDecimal(json, 'fee'),
        numberOfFills = nullableInt(json, 'number_of_fills'),
        filledValue = nullableDecimal(json, 'filled_value'),
        pendingCancel = json['pending_cancel'],
        sizeInQuote = json['size_in_quote'],
        totalFees = nullableDecimal(json, 'total_fees'),
        sizeInclusiveOfFees = json['size_inclusive_of_fees'],
        totalValueAfterFees = nullableDecimal(json, 'total_value_after_fees'),
        triggerStatus = TriggerStatus.fromCB(json['trigger_status']),
        orderType = OrderType.fromCB(json['order_type']),
        rejectReason = RejectReason.fromCB(json['reject_reason']),
        settled = json['settled'],
        productType = ProductType.fromCB(json['product_type']),
        rejectMessage = json['reject_message'],
        cancelMessage = json['cancel_message'];

  /// Converts an Order to a Coinbase JSON object.
  Map<String, dynamic> toCBJson() => {
        'order_id': orderId,
        'product_id': productId,
        'user_id': userId,
        'order_configuration': orderConfiguration?.toCBJson(),
        'side': side?.toCB(),
        'client_order_id': clientOrderId,
        'status': status?.toCB(),
        'time_in_force': timeInForce?.toCB(),
        'created_time': createdTime?.toIso8601String(),
        'completion_percentage': completionPercentage?.toString(),
        'filled_size': filledSize?.toString(),
        'average_filled_price': averageFilledPrice?.toString(),
        'fee': fee?.toString(),
        'number_of_fills': numberOfFills,
        'filled_value': filledValue?.toString(),
        'pending_cancel': pendingCancel,
        'size_in_quote': sizeInQuote,
        'total_fees': totalFees?.toString(),
        'size_inclusive_of_fees': sizeInclusiveOfFees,
        'total_value_after_fees': totalValueAfterFees?.toString(),
        'trigger_status': triggerStatus?.toCB(),
        'order_type': orderType?.toCB(),
        'reject_reason': rejectReason?.toCB(),
        'settled': settled,
        'product_type': productType?.toCB(),
        'reject_message': rejectMessage,
        'cancel_message': cancelMessage
      };

  @override
  String toString() {
    String all = '{'
        'orderId=$orderId, productId=$productId, userId=$userId, '
        'orderConfiguration=$orderConfiguration, side=$side, '
        'clientOrderId=$clientOrderId, status=$status, '
        'timeInForce=$timeInForce, createdTime=$createdTime, '
        'completionPercentage=$completionPercentage, filledSize=$filledSize, '
        'averageFilledPrice=$averageFilledPrice, fee=$fee, '
        'numberOfFills=$numberOfFills, filledValue=$filledValue, '
        'pendingCancel=$pendingCancel, sizeInQuote=$sizeInQuote, '
        'totalFees=$totalFees, sizeInclusiveOfFees=$sizeInclusiveOfFees, '
        'totalValueAfterFees=$totalValueAfterFees, '
        'triggerStatus=$triggerStatus, orderType=$orderType,'
        'rejectReason=$rejectReason, settled=$settled, '
        'productType=$productType, rejectMessage=$rejectMessage, '
        'cancelMessage=$cancelMessage'
        '}';
    return all;
  }
}
