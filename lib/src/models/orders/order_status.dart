/// The status of an order.
enum OrderStatus {
  /// An unknown order status.
  unknownOrderStatus('UNKNOWN_ORDER_STATUS'),

  /// The order is open.
  open('OPEN'),

  /// The order is filled.
  filled('FILLED'),

  /// The order is cancelled.
  cancelled('CANCELLED'),

  /// The order has expired.
  expired('EXPIRED'),

  /// The order has failed.
  failed('FAILED'),

  /// The order is pending.
  pending('PENDING');

  const OrderStatus(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts an OrderStatus to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates an OrderStatus from a Coinbase string.
  static OrderStatus fromCB(String cb) {
    return OrderStatus.values.firstWhere((e) => e.value == cb,
        orElse: () => OrderStatus.unknownOrderStatus);
  }
}
