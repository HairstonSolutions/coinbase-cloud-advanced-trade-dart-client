/// The time in force of an order.
enum TimeInForce {
  /// An unknown time in force.
  UNKNOWN_TIME_IN_FORCE,

  /// The order is good until cancelled.
  GOOD_UNTIL_CANCELLED,

  /// The order is good until a specific date and time.
  GOOD_UNTIL_DATE_TIME,

  /// The order is immediate or cancel.
  IMMEDIATE_OR_CANCEL,

  /// The order is fill or kill.
  FILL_OR_KILL;

  /// Converts a TimeInForce to a Coinbase string.
  String toCB() {
    return name;
  }

  /// Creates a TimeInForce from a Coinbase string.
  static TimeInForce fromCB(String cb) {
    return TimeInForce.values.firstWhere((e) => e.name == cb,
        orElse: () => TimeInForce.UNKNOWN_TIME_IN_FORCE);
  }
}
