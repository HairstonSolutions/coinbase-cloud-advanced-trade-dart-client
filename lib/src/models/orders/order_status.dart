enum OrderStatus {
  UNKNOWN_ORDER_STATUS,
  OPEN,
  FILLED,
  CANCELLED,
  EXPIRED,
  FAILED,
  PENDING;

  String toCB() {
    return name;
  }

  static OrderStatus fromCB(String cb) {
    return OrderStatus.values.firstWhere((e) => e.name == cb,
        orElse: () => OrderStatus.UNKNOWN_ORDER_STATUS);
  }
}
