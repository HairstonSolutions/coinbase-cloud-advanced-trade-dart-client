/// The type of an order.
enum OrderType {
  /// An unknown order type.
  UNKNOWN_ORDER_TYPE,

  /// A limit order.
  LIMIT,

  /// A market order.
  MARKET,

  /// A stop order.
  STOP,

  /// A stop-limit order.
  STOP_LIMIT;

  /// Converts an OrderType to a Coinbase string.
  String toCB() {
    return name;
  }

  /// Creates an OrderType from a Coinbase string.
  static OrderType fromCB(String cb) {
    return OrderType.values.firstWhere((e) => e.name == cb,
        orElse: () => OrderType.UNKNOWN_ORDER_TYPE);
  }
}
