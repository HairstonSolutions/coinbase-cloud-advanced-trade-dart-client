/// The side of the order.
enum OrderSide {
  /// An unknown order side.
  UNKNOWN_ORDER_SIDE,

  /// A buy order.
  BUY,

  /// A sell order.
  SELL;

  /// Converts an OrderSide to a Coinbase string.
  String toCB() {
    return name;
  }

  /// Creates an OrderSide from a Coinbase string.
  static OrderSide fromCB(String cb) {
    return OrderSide.values.firstWhere((e) => e.name == cb,
        orElse: () => OrderSide.UNKNOWN_ORDER_SIDE);
  }
}
