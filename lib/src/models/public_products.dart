import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';

class PublicProducts {
  final List<Product> products;
  final int numProducts;

  PublicProducts(this.products, this.numProducts);

  factory PublicProducts.fromCBJson(Map<String, dynamic> json) {
    var products = <Product>[];
    for (var product in json['products']) {
      products.add(Product.fromCBJson(product));
    }

    return PublicProducts(
      products,
      json['num_products'],
    );
  }
}
