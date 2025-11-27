/// The status of a trigger.
enum TriggerStatus {
  /// An unknown trigger status.
  unknownTriggerStatus('UNKNOWN_TRIGGER_STATUS'),

  /// An invalid order type.
  invalidOrderType('INVALID_ORDER_TYPE'),

  /// A stop order is pending.
  stopPending('STOP_PENDING'),

  /// A stop order has been triggered.
  stopTriggered('STOP_TRIGGERED');

  const TriggerStatus(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts a TriggerStatus to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates a TriggerStatus from a Coinbase string.
  static TriggerStatus fromCB(String cb) {
    return TriggerStatus.values.firstWhere((e) => e.value == cb,
        orElse: () => TriggerStatus.unknownTriggerStatus);
  }
}
