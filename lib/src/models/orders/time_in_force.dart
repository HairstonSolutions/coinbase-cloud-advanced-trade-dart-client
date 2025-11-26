enum TimeInForce {
  UNKNOWN_TIME_IN_FORCE,
  GOOD_UNTIL_CANCELLED,
  GOOD_UNTIL_DATE_TIME,
  IMMEDIATE_OR_CANCEL,
  FILL_OR_KILL;

  String toCB() {
    return name;
  }

  static TimeInForce fromCB(String cb) {
    return TimeInForce.values.firstWhere((e) => e.name == cb,
        orElse: () => TimeInForce.UNKNOWN_TIME_IN_FORCE);
  }
}
