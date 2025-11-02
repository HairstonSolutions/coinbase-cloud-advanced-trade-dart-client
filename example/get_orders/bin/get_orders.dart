import 'package:coinbase_pro_sdk/pro.dart';

void main(List<String> arguments) async {
  // Create a credential object with your Access key, Secret key and Pass Phrase.
  // It is recommended to store these securely, for example, using environment variables.
  final credential = Credential(
    'YOUR_ACCESS_KEY',
    'YOUR_SECRET_KEY',
    'PASSPHRASE',
  );

  // Get a list of orders.
  try {
    List<Order> orders = await getOrders(credential: credential);
    for (var order in orders) {
      print('Order: ${order.id}, Status: ${order.status}');
    }
  } catch (e) {
    print('Error getting orders: $e');
  }
}
