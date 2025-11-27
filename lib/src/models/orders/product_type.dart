/// The type of a product.
enum ProductType {
  /// An unknown product type.
  unknownProductType('UNKNOWN_PRODUCT_TYPE'),

  /// A spot product.
  spot('SPOT');

  const ProductType(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts a ProductType to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates a ProductType from a Coinbase string.
  static ProductType fromCB(String cb) {
    return ProductType.values.firstWhere((e) => e.value == cb,
        orElse: () => ProductType.unknownProductType);
  }
}
