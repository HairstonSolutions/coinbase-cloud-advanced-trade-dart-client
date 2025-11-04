class ClosePositionErrorResponse {
  final String error;
  final String message;
  final String errorDetails;
  final String previewFailureReason;
  final String newOrderFailureReason;

  ClosePositionErrorResponse(
      {required this.error,
      required this.message,
      required this.errorDetails,
      required this.previewFailureReason,
      required this.newOrderFailureReason});

  factory ClosePositionErrorResponse.fromCBJson(Map<String, dynamic> json) {
    return ClosePositionErrorResponse(
      error: json['error'],
      message: json['message'],
      errorDetails: json['error_details'],
      previewFailureReason: json['preview_failure_reason'],
      newOrderFailureReason: json['new_order_failure_reason'],
    );
  }
}
