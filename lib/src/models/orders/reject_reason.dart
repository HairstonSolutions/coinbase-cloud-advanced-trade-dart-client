/// The reason an order was rejected.
enum RejectReason {
  /// An unspecified reason.
  REJECT_REASON_UNSPECIFIED,

  /// The product ID was invalid.
  INVALID_PRODUCT_ID,

  /// The order type was invalid.
  INVALID_ORDER_TYPE,

  /// The side was invalid.
  INVALID_SIDE,

  /// The client order ID was invalid.
  INVALID_CLIENT_ORDER_ID,

  /// The size was invalid.
  INVALID_SIZE,

  /// The price was invalid.
  INVALID_PRICE,

  /// There were insufficient funds.
  INSUFFICIENT_FUNDS;

  /// Converts a RejectReason to a Coinbase string.
  String toCB() {
    return name;
  }

  /// Creates a RejectReason from a Coinbase string.
  static RejectReason fromCB(String cb) {
    return RejectReason.values.firstWhere((e) => e.name == cb,
        orElse: () => RejectReason.REJECT_REASON_UNSPECIFIED);
  }
}
