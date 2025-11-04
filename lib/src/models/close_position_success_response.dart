class ClosePositionSuccessResponse {
  final String orderId;
  final String productId;
  final String side;
  final String clientOrderId;

  ClosePositionSuccessResponse(
      {required this.orderId,
      required this.productId,
      required this.side,
      required this.clientOrderId});

  factory ClosePositionSuccessResponse.fromCBJson(Map<String, dynamic> json) {
    return ClosePositionSuccessResponse(
      orderId: json['order_id'],
      productId: json['product_id'],
      side: json['side'],
      clientOrderId: json['client_order_id'],
    );
  }
}
