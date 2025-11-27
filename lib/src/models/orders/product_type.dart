/// The type of a product.
enum ProductType {
  /// An unknown product type.
  UNKNOWN_PRODUCT_TYPE,

  /// A spot product.
  SPOT;

  /// Converts a ProductType to a Coinbase string.
  String toCB() {
    return name;
  }

  /// Creates a ProductType from a Coinbase string.
  static ProductType fromCB(String cb) {
    return ProductType.values.firstWhere((e) => e.name == cb,
        orElse: () => ProductType.UNKNOWN_PRODUCT_TYPE);
  }
}
