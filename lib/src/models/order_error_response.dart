class OrderErrorResponse {
  final String error;
  final String message;
  final String errorDetails;
  final String previewId;

  OrderErrorResponse({
    required this.error,
    required this.message,
    required this.errorDetails,
    required this.previewId,
  });

  factory OrderErrorResponse.fromCBJson(Map<String, dynamic> json) {
    return OrderErrorResponse(
      error: json['error'],
      message: json['message'],
      errorDetails: json['error_details'],
      previewId: json['preview_id'],
    );
  }
}
