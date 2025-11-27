/// The direction of a stop order.
enum StopDirection {
  /// An unknown stop direction.
  unknownStopDirection('UNKNOWN_STOP_DIRECTION'),

  /// A stop order that triggers when the price goes down.
  stopDirectionStopDown('STOP_DIRECTION_STOP_DOWN'),

  /// A stop order that triggers when the price goes up.
  stopDirectionStopUp('STOP_DIRECTION_STOP_UP');

  const StopDirection(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts a StopDirection to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates a StopDirection from a Coinbase string.
  static StopDirection fromCB(String cb) {
    return StopDirection.values.firstWhere((e) => e.value == cb,
        orElse: () => StopDirection.unknownStopDirection);
  }
}
