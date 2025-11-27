/// The status of an order.
enum OrderStatus {
  /// An unknown order status.
  UNKNOWN_ORDER_STATUS,

  /// The order is open.
  OPEN,

  /// The order is filled.
  FILLED,

  /// The order is cancelled.
  CANCELLED,

  /// The order has expired.
  EXPIRED,

  /// The order has failed.
  FAILED,

  /// The order is pending.
  PENDING;

  /// Converts an OrderStatus to a Coinbase string.
  String toCB() {
    return name;
  }

  /// Creates an OrderStatus from a Coinbase string.
  static OrderStatus fromCB(String cb) {
    return OrderStatus.values.firstWhere((e) => e.name == cb,
        orElse: () => OrderStatus.UNKNOWN_ORDER_STATUS);
  }
}
