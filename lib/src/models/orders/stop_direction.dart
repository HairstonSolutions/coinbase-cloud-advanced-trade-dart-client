/// The direction of a stop order.
enum StopDirection {
  /// An unknown stop direction.
  UNKNOWN_STOP_DIRECTION,

  /// A stop order that triggers when the price goes down.
  STOP_DIRECTION_STOP_DOWN,

  /// A stop order that triggers when the price goes up.
  STOP_DIRECTION_STOP_UP;

  /// Converts a StopDirection to a Coinbase string.
  String toCB() {
    return name;
  }

  /// Creates a StopDirection from a Coinbase string.
  static StopDirection fromCB(String cb) {
    return StopDirection.values.firstWhere((e) => e.name == cb,
        orElse: () => StopDirection.UNKNOWN_STOP_DIRECTION);
  }
}
