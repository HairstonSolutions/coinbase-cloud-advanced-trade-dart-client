enum ProductType {
  UNKNOWN_PRODUCT_TYPE,
  SPOT;

  String toCB() {
    return name;
  }

  static ProductType fromCB(String cb) {
    return ProductType.values.firstWhere((e) => e.name == cb,
        orElse: () => ProductType.UNKNOWN_PRODUCT_TYPE);
  }
}
