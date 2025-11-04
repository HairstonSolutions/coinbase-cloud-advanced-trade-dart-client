class CancelOrderResult {
  final bool success;
  final String failureReason;
  final String orderId;

  CancelOrderResult(this.success, this.failureReason, this.orderId);

  factory CancelOrderResult.fromCBJson(Map<String, dynamic> json) {
    return CancelOrderResult(
      json['success'],
      json['failure_reason'],
      json['order_id'],
    );
  }
}
