/// The side of the order.
enum OrderSide {
  /// An unknown order side.
  unknownOrderSide('UNKNOWN_ORDER_SIDE'),

  /// A buy order.
  buy('BUY'),

  /// A sell order.
  sell('SELL');

  const OrderSide(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts an OrderSide to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates an OrderSide from a Coinbase string.
  static OrderSide fromCB(String cb) {
    return OrderSide.values.firstWhere((e) => e.value == cb,
        orElse: () => OrderSide.unknownOrderSide);
  }
}
