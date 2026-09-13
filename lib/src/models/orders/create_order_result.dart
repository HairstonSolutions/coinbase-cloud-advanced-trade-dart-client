import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_side.dart';

/// The reason an order was rejected by the Coinbase API.
enum OrderRejectReason {
  /// The client order ID was a duplicate.
  duplicateClientOrderId('DUPLICATE_CLIENT_ORDER_ID'),

  /// The order was a post-only limit order that would cross the order book.
  postOnlyWouldCross('INVALID_LIMIT_PRICE_POST_ONLY'),

  /// The account has insufficient funds.
  insufficientFunds('INSUFFICIENT_FUND'),

  /// The order is invalid.
  invalidOrder('INVALID_ORDER'),

  /// An unknown error occurred.
  unknown('UNKNOWN');

  /// The string representation of the reason.
  final String value;
  const OrderRejectReason(this.value);

  /// Creates a reason from a Coinbase string.
  static OrderRejectReason fromCB(String? cb) {
    if (cb == null) return OrderRejectReason.unknown;
    // INSUFFICIENT_FUND and INSUFFICIENT_FUNDS are sometimes interchanged.
    if (cb == 'INSUFFICIENT_FUND' || cb == 'INSUFFICIENT_FUNDS') {
      return OrderRejectReason.insufficientFunds;
    }
    return OrderRejectReason.values.firstWhere(
      (e) => e.value == cb,
      orElse: () => OrderRejectReason.unknown,
    );
  }
}

/// The result of creating an order.
sealed class CreateOrderResult {
  /// The raw response map from the Coinbase API.
  final Map<String, dynamic> raw;

  const CreateOrderResult(this.raw);
}

/// A successfully created order.
class OrderSuccess extends CreateOrderResult {
  /// The order ID.
  final String orderId;

  /// The client order ID.
  final String? clientOrderId;

  /// The product ID.
  final String? productId;

  /// The side of the order.
  final OrderSide? side;

  /// Creates a successful order result.
  const OrderSuccess({
    required this.orderId,
    this.clientOrderId,
    this.productId,
    this.side,
    required Map<String, dynamic> raw,
  }) : super(raw);

  /// Creates a successful order result from a JSON map.
  factory OrderSuccess.fromCBJson(Map<String, dynamic> json) {
    final successResponse = json['success_response'] ?? {};
    final orderId = successResponse['order_id'] ?? json['order_id'] ?? '';
    final clientOrderId =
        successResponse['client_order_id'] ?? json['client_order_id'];
    final productId = successResponse['product_id'] ?? json['product_id'];
    final sideStr = successResponse['side'] ?? json['side'];

    return OrderSuccess(
      orderId: orderId,
      clientOrderId: clientOrderId,
      productId: productId,
      side: sideStr != null ? OrderSide.fromCB(sideStr) : null,
      raw: json,
    );
  }

  @override
  String toString() {
    return 'OrderSuccess(orderId: $orderId, clientOrderId: $clientOrderId, productId: $productId, side: $side, raw: $raw)';
  }
}

/// An order that was rejected.
class OrderRejected extends CreateOrderResult {
  /// The failure reason string.
  final String? failureReason;

  /// The error message.
  final String? message;

  /// The order ID, if available.
  final String? orderId;

  /// The parsed failure reason.
  final OrderRejectReason reason;

  /// Creates a rejected order result.
  const OrderRejected({
    this.failureReason,
    this.message,
    this.orderId,
    required this.reason,
    required Map<String, dynamic> raw,
  }) : super(raw);

  /// Creates a rejected order result from a JSON map.
  factory OrderRejected.fromCBJson(Map<String, dynamic> json) {
    final errorResponse = json['error_response'] ?? {};
    final failureReason =
        errorResponse['new_order_failure_reason'] ?? json['failure_reason'];
    final message = errorResponse['message'] ?? json['message'];

    // Sometimes DUPLICATE_CLIENT_ORDER_ID provides the existing order_id in the raw response or success_response incorrectly
    final orderId = json['order_id'] ??
        json['success_response']?['order_id'] ??
        errorResponse['order_id'];

    return OrderRejected(
      failureReason: failureReason,
      message: message,
      orderId: orderId,
      reason: OrderRejectReason.fromCB(failureReason),
      raw: json,
    );
  }

  @override
  String toString() {
    return 'OrderRejected(failureReason: $failureReason, message: $message, orderId: $orderId, reason: $reason, raw: $raw)';
  }
}
