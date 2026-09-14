/// The time in force of an order.
enum TimeInForce {
  /// An unknown time in force.
  unknownTimeInForce('UNKNOWN_TIME_IN_FORCE'),

  /// The order is good until cancelled.
  goodUntilCancelled('GOOD_UNTIL_CANCELLED'),

  /// The order is good until a specific date and time.
  goodUntilDateTime('GOOD_UNTIL_DATE_TIME'),

  /// The order is immediate or cancel.
  immediateOrCancel('IMMEDIATE_OR_CANCEL'),

  /// The order is fill or kill.
  fillOrKill('FILL_OR_KILL');

  const TimeInForce(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts a TimeInForce to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates a TimeInForce from a Coinbase string.
  ///
  /// Returns [TimeInForce.unknownTimeInForce] when [cb] is null or
  /// unrecognised, so a payload that omits the field does not throw.
  static TimeInForce fromCB(String? cb) {
    if (cb == null) return TimeInForce.unknownTimeInForce;
    return TimeInForce.values.firstWhere((e) => e.value == cb,
        orElse: () => TimeInForce.unknownTimeInForce);
  }
}
