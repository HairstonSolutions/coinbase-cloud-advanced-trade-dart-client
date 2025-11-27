enum OrderSide {
  UNKNOWN_ORDER_SIDE,
  BUY,
  SELL;

  String toCB() {
    return name;
  }

  static OrderSide fromCB(String cb) {
    return OrderSide.values.firstWhere((e) => e.name == cb,
        orElse: () => OrderSide.UNKNOWN_ORDER_SIDE);
  }
}
