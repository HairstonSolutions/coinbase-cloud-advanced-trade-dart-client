class CancelOrdersResult {
  final bool? success;
  final String? failureReason;
  final String? orderId;

  CancelOrdersResult({this.success, this.failureReason, this.orderId});

  factory CancelOrdersResult.fromCBJson(Map<String, dynamic> json) {
    return CancelOrdersResult(
      success: json['success'],
      failureReason: json['failure_reason'],
      orderId: json['order_id'],
    );
  }

  @override
  String toString() {
    return 'CancelOrdersResult{success: $success, failureReason: $failureReason, orderId: $orderId}';
  }
}

class CancelOrders {
  final List<CancelOrdersResult>? results;

  CancelOrders({this.results});

  factory CancelOrders.fromCBJson(Map<String, dynamic> json) {
    var resultsList = json['results'] as List;
    List<CancelOrdersResult> results = resultsList.isNotEmpty
        ? resultsList.map((i) => CancelOrdersResult.fromCBJson(i)).toList()
        : [];
    return CancelOrders(results: results);
  }
}
