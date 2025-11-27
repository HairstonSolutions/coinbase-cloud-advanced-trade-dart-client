/// The reason an order was rejected.
enum RejectReason {
  /// An unspecified reason.
  rejectReasonUnspecified('REJECT_REASON_UNSPECIFIED'),

  /// The product ID was invalid.
  invalidProductId('INVALID_PRODUCT_ID'),

  /// The order type was invalid.
  invalidOrderType('INVALID_ORDER_TYPE'),

  /// The side was invalid.
  invalidSide('INVALID_SIDE'),

  /// The client order ID was invalid.
  invalidClientOrderId('INVALID_CLIENT_ORDER_ID'),

  /// The size was invalid.
  invalidSize('INVALID_SIZE'),

  /// The price was invalid.
  invalidPrice('INVALID_PRICE'),

  /// There were insufficient funds.
  insufficientFunds('INSUFFICIENT_FUNDS');

  const RejectReason(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts a RejectReason to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates a RejectReason from a Coinbase string.
  static RejectReason fromCB(String cb) {
    return RejectReason.values.firstWhere((e) => e.value == cb,
        orElse: () => RejectReason.rejectReasonUnspecified);
  }
}
