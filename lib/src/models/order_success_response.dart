class OrderSuccessResponse {
  final String orderId;
  final String productId;
  final String side;
  final String clientOrderId;

  OrderSuccessResponse({
    required this.orderId,
    required this.productId,
    required this.side,
    required this.clientOrderId,
  });

  factory OrderSuccessResponse.fromCBJson(Map<String, dynamic> json) {
    return OrderSuccessResponse(
      orderId: json['order_id'],
      productId: json['product_id'],
      side: json['side'],
      clientOrderId: json['client_order_id'],
    );
  }
}
