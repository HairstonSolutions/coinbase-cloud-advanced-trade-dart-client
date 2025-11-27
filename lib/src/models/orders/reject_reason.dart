enum RejectReason {
  REJECT_REASON_UNSPECIFIED,
  INVALID_PRODUCT_ID,
  INVALID_ORDER_TYPE,
  INVALID_SIDE,
  INVALID_CLIENT_ORDER_ID,
  INVALID_SIZE,
  INVALID_PRICE,
  INSUFFICIENT_FUNDS;

  String toCB() {
    return name;
  }

  static RejectReason fromCB(String cb) {
    return RejectReason.values.firstWhere((e) => e.name == cb,
        orElse: () => RejectReason.REJECT_REASON_UNSPECIFIED);
  }
}
