import 'package:coinbase_pro_sdk/pro.dart';

void main(List<String> arguments) async {
  // Get a list of products.
  try {
    List<Product> products = await getProducts();
    for (var product in products) {
      print('Product: ${product.displayName}');
    }
  } catch (e) {
    print('Error getting products: $e');
  }

  // Get a single product.
  try {
    Product? product = await getProduct('BTC-USD');
    if (product != null) {
      print('Product: $product, Price: ${product.id}');
    }
  } catch (e) {
    print('Error getting product: $e');
  }
}
