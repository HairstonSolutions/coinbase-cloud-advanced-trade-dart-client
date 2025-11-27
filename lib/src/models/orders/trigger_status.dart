/// The status of a trigger.
enum TriggerStatus {
  /// An unknown trigger status.
  UNKNOWN_TRIGGER_STATUS,

  /// An invalid order type.
  INVALID_ORDER_TYPE,

  /// A stop order is pending.
  STOP_PENDING,

  /// A stop order has been triggered.
  STOP_TRIGGERED;

  /// Converts a TriggerStatus to a Coinbase string.
  String toCB() {
    return name;
  }

  /// Creates a TriggerStatus from a Coinbase string.
  static TriggerStatus fromCB(String cb) {
    return TriggerStatus.values.firstWhere((e) => e.name == cb,
        orElse: () => TriggerStatus.UNKNOWN_TRIGGER_STATUS);
  }
}
