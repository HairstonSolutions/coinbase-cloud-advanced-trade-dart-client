enum StopDirection {
  UNKNOWN_STOP_DIRECTION,
  STOP_DIRECTION_STOP_DOWN,
  STOP_DIRECTION_STOP_UP;

  String toCB() {
    return name;
  }

  static StopDirection fromCB(String cb) {
    return StopDirection.values.firstWhere((e) => e.name == cb,
        orElse: () => StopDirection.UNKNOWN_STOP_DIRECTION);
  }
}
