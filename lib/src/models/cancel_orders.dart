/// The result of a canceled order.
class CanceledOrderResult {
  /// Whether the order was successfully canceled.
  final bool? success;

  /// The reason for the failure.
  final String? failureReason;

  /// The ID of the order.
  final String? orderId;

  /// CanceledOrderResult constructor
  CanceledOrderResult({this.success, this.failureReason, this.orderId});

  /// Creates a CanceledOrderResult from a Coinbase JSON object.
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

/// A list of canceled order results.
class CanceledOrders {
  /// The list of canceled order results.
  final List<CanceledOrderResult>? canceledOrderResults;

  /// CanceledOrders constructor
  CanceledOrders({this.canceledOrderResults});

  /// Creates a CanceledOrders from a Coinbase JSON object.
  factory CanceledOrders.fromCBJson(Map<String, dynamic> json) {
    var resultsList = json['results'] as List;
    List<CanceledOrderResult> results = resultsList.isNotEmpty
        ? resultsList.map((i) => CanceledOrderResult.fromCBJson(i)).toList()
        : [];
    return CanceledOrders(canceledOrderResults: results);
  }
}
