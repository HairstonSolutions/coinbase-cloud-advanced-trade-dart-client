enum TriggerStatus {
  UNKNOWN_TRIGGER_STATUS,
  INVALID_ORDER_TYPE,
  STOP_PENDING,
  STOP_TRIGGERED;

  String toCB() {
    return name;
  }

  static TriggerStatus fromCB(String cb) {
    return TriggerStatus.values.firstWhere((e) => e.name == cb,
        orElse: () => TriggerStatus.UNKNOWN_TRIGGER_STATUS);
  }
}
