import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

class Order {
  final String? orderId;
  final String? productId;
  final String? userId;
  final OrderConfiguration? orderConfiguration;
  final String? side;
  final String? clientOrderId;
  final String? status;
  final String? timeInForce;
  final DateTime? createdTime;
  final double? completionPercentage;
  final double? filledSize;
  final double? averageFilledPrice;
  final String? fee;
  final double? numberOfFills;
  final double? filledValue;
  final bool? pendingCancel;
  final bool? sizeInQuote;
  final double? totalFees;
  final bool? sizeInclusiveOfFees;
  final double? totalValueAfterFees;
  final String? triggerStatus;
  final String? orderType;
  final String? rejectReason;
  final bool? settled;
  final String? productType;
  final String? rejectMessage;
  final String? cancelMessage;

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

  Order.fromJson(Map<String, dynamic> json)
      : orderId = json['orderId'],
        productId = json['productId'],
        userId = json['userId'],
        orderConfiguration = json['orderConfiguration'],
        side = json['side'],
        clientOrderId = json['clientOrderId'],
        status = json['status'],
        timeInForce = json['timeInForce'],
        createdTime = DateTime.parse(json['createdTime']),
        completionPercentage = json['completionPercentage'],
        filledSize = json['filledSize'],
        averageFilledPrice = json['averageFilledPrice'],
        fee = json['fee'],
        numberOfFills = json['numberOfFills'],
        filledValue = json['filledValue'],
        pendingCancel = json['pendingCancel'],
        sizeInQuote = json['sizeInQuote'],
        totalFees = json['totalFees'],
        sizeInclusiveOfFees = json['sizeInclusiveOfFees'],
        totalValueAfterFees = json['totalValueAfterFees'],
        triggerStatus = json['triggerStatus'],
        orderType = json['orderType'],
        rejectReason = json['rejectReason'],
        settled = json['settled'],
        productType = json['productType'],
        rejectMessage = json['rejectMessage'],
        cancelMessage = json['cancelMessage'];

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'productId': productId,
        'userId': userId,
        'orderConfiguration': orderConfiguration,
        'side': side,
        'clientOrderId': clientOrderId,
        'status': status,
        'timeInForce': timeInForce,
        'createdTime': createdTime?.toIso8601String(),
        'completionPercentage': completionPercentage,
        'filledSize': filledSize,
        'averageFilledPrice': averageFilledPrice,
        'fee': fee,
        'numberOfFills': numberOfFills,
        'filledValue': filledValue,
        'pendingCancel': pendingCancel,
        'sizeInQuote': sizeInQuote,
        'totalFees': totalFees,
        'sizeInclusiveOfFees': sizeInclusiveOfFees,
        'totalValueAfterFees': totalValueAfterFees,
        'triggerStatus': triggerStatus,
        'orderType': orderType,
        'rejectReason': rejectReason,
        'settled': settled,
        'productType': productType,
        'rejectMessage': rejectMessage,
        'cancelMessage': cancelMessage
      };

  Order.fromCBJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        productId = json['product_id'],
        userId = json['user_id'],
        orderConfiguration =
            OrderConfiguration.fromCBJson(json['order_configuration']),
        side = json['side'],
        clientOrderId = json['client_order_id'],
        status = json['status'],
        timeInForce = json['time_in_force'],
        createdTime = DateTime.parse(json['created_time']),
        completionPercentage = nullableDouble(json, 'completion_percentage'),
        filledSize = nullableDouble(json, 'filled_size'),
        averageFilledPrice = nullableDouble(json, 'average_filled_price'),
        fee = json['fee'],
        numberOfFills = nullableDouble(json, 'number_of_fills'),
        filledValue = nullableDouble(json, 'filled_value'),
        pendingCancel = json['pending_cancel'],
        sizeInQuote = json['size_in_quote'],
        totalFees = nullableDouble(json, 'total_fees'),
        sizeInclusiveOfFees = json['size_inclusive_of_fees'],
        totalValueAfterFees = nullableDouble(json, 'total_value_after_fees'),
        triggerStatus = json['trigger_status'],
        orderType = json['order_type'],
        rejectReason = json['reject_reason'],
        settled = json['settled'],
        productType = json['product_type'],
        rejectMessage = json['reject_message'],
        cancelMessage = json['cancel_message'];

  Map<String, dynamic> toCBJson() => {
        'order_id': orderId,
        'product_id': productId,
        'user_id': userId,
        'order_configuration': orderConfiguration?.toCBJson(),
        'side': side,
        'client_order_id': clientOrderId,
        'status': status,
        'time_in_force': timeInForce,
        'created_time': createdTime?.toIso8601String(),
        'completion_percentage': completionPercentage,
        'filled_size': filledSize,
        'average_filled_price': averageFilledPrice,
        'fee': fee,
        'number_of_fills': numberOfFills,
        'filled_value': filledValue,
        'pending_cancel': pendingCancel,
        'size_in_quote': sizeInQuote,
        'total_fees': totalFees,
        'size_inclusive_of_fees': sizeInclusiveOfFees,
        'total_value_after_fees': totalValueAfterFees,
        'trigger_status': triggerStatus,
        'order_type': orderType,
        'reject_reason': rejectReason,
        'settled': settled,
        'product_type': productType,
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
