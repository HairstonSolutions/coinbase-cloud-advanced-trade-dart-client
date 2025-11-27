enum OrderType {
  UNKNOWN_ORDER_TYPE,
  LIMIT,
  MARKET,
  STOP,
  STOP_LIMIT;

  String toCB() {
    return name;
  }

  static OrderType fromCB(String cb) {
    return OrderType.values.firstWhere((e) => e.name == cb,
        orElse: () => OrderType.UNKNOWN_ORDER_TYPE);
  }
}
