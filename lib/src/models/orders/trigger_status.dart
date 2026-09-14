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
  ///
  /// Returns [TriggerStatus.unknownTriggerStatus] when [cb] is null or
  /// unrecognised, so a payload that omits the field does not throw.
  static TriggerStatus fromCB(String? cb) {
    if (cb == null) return TriggerStatus.unknownTriggerStatus;
    return TriggerStatus.values.firstWhere((e) => e.value == cb,
        orElse: () => TriggerStatus.unknownTriggerStatus);
  }
}
