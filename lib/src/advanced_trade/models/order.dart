import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order_configuration.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/shared/services/tools.dart';

class Order {
  final String? orderId;
  final String? productId;
  final String? userId;
  final OrderConfiguration? orderConfiguration;
  final String? side;
  final String? clientOrderId;
  final String? status;
  final String? timeInForce;
  final String? createdTime;
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

  static Order convertJson(var jsonObject) {
    String? orderId = jsonObject['order_id'];
    String? productId = jsonObject['product_id'];
    String? userId = jsonObject['user_id'];
    OrderConfiguration? orderConfiguration =
        OrderConfiguration.convertJson(jsonObject['order_configuration']);
    String? side = jsonObject['side'];
    String? clientOrderId = jsonObject['client_order_id'];
    String? status = jsonObject['status'];
    String? timeInForce = jsonObject['time_in_force'];
    String? createdTime = jsonObject['created_time'];
    double? completionPercentage =
        nullableDouble(jsonObject, 'completion_percentage');
    double? filledSize = nullableDouble(jsonObject, 'filled_size');
    double? averageFilledPrice =
        nullableDouble(jsonObject, 'average_filled_price');
    String? fee = jsonObject['fee'];
    double? numberOfFills = nullableDouble(jsonObject, 'number_of_fills');
    double? filledValue = nullableDouble(jsonObject, 'filled_value');
    bool? pendingCancel = jsonObject['pending_cancel'];
    bool? sizeInQuote = jsonObject['size_in_quote'];
    double? totalFees = nullableDouble(jsonObject, 'total_fees');
    bool? sizeInclusiveOfFees = jsonObject['size_inclusive_of_fees'];
    double? totalValueAfterFees =
        nullableDouble(jsonObject, 'total_value_after_fees');
    String? triggerStatus = jsonObject['trigger_status'];
    String? orderType = jsonObject['order_type'];
    String? rejectReason = jsonObject['reject_reason'];
    bool? settled = jsonObject['settled'];
    String? productType = jsonObject['product_type'];
    String? rejectMessage = jsonObject['reject_message'];
    String? cancelMessage = jsonObject['cancel_message'];

    return Order(
        orderId,
        productId,
        userId,
        orderConfiguration,
        side,
        clientOrderId,
        status,
        timeInForce,
        createdTime,
        completionPercentage,
        filledSize,
        averageFilledPrice,
        fee,
        numberOfFills,
        filledValue,
        pendingCancel,
        sizeInQuote,
        totalFees,
        sizeInclusiveOfFees,
        totalValueAfterFees,
        triggerStatus,
        orderType,
        rejectReason,
        settled,
        productType,
        rejectMessage,
        cancelMessage);
  }
}
