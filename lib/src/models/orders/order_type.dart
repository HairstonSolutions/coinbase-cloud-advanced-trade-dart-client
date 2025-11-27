/// The type of an order.
enum OrderType {
  /// An unknown order type.
  unknownOrderType('UNKNOWN_ORDER_TYPE'),

  /// A limit order.
  limit('LIMIT'),

  /// A market order.
  market('MARKET'),

  /// A stop order.
  stop('STOP'),

  /// A stop-limit order.
  stopLimit('STOP_LIMIT');

  const OrderType(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts an OrderType to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates an OrderType from a Coinbase string.
  static OrderType fromCB(String cb) {
    return OrderType.values.firstWhere((e) => e.value == cb,
        orElse: () => OrderType.unknownOrderType);
  }
}
