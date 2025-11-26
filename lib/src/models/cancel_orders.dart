class CanceledOrderResult {
  final bool? success;
  final String? failureReason;
  final String? orderId;

  CanceledOrderResult({this.success, this.failureReason, this.orderId});

  factory CanceledOrderResult.fromCBJson(Map<String, dynamic> json) {
    return CanceledOrderResult(
      success: json['success'],
      failureReason: json['failure_reason'],
      orderId: json['order_id'],
    );
  }

  @override
  String toString() {
    return 'CanceledOrderResult{success: $success, failureReason: $failureReason, orderId: $orderId}';
  }
}

class CanceledOrders {
  final List<CanceledOrderResult>? canceledOrderResults;

  CanceledOrders({this.canceledOrderResults});

  factory CanceledOrders.fromCBJson(Map<String, dynamic> json) {
    var resultsList = json['results'] as List;
    List<CanceledOrderResult> results = resultsList.isNotEmpty
        ? resultsList.map((i) => CanceledOrderResult.fromCBJson(i)).toList()
        : [];
    return CanceledOrders(canceledOrderResults: results);
  }
}
