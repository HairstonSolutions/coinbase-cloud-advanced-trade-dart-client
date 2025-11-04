import 'order_error_response.dart';
import 'order_success_response.dart';

class OrderResult {
  final bool success;
  final String failureReason;
  final String orderId;
  final OrderSuccessResponse? successResponse;
  final OrderErrorResponse? errorResponse;

  OrderResult({
    required this.success,
    required this.failureReason,
    required this.orderId,
    this.successResponse,
    this.errorResponse,
  });

  factory OrderResult.fromCBJson(Map<String, dynamic> json) {
    return OrderResult(
      success: json['success'],
      failureReason: json['failure_reason'],
      orderId: json['order_id'],
      successResponse: json['success_response'] != null
          ? OrderSuccessResponse.fromCBJson(json['success_response'])
          : null,
      errorResponse: json['error_response'] != null
          ? OrderErrorResponse.fromCBJson(json['error_response'])
          : null,
    );
  }
}
