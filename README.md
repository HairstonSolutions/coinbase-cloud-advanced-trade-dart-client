# Coinbase Advanced Trade API Client

[![pub version](https://img.shields.io/pub/v/coinbase_cloud_advanced_trade_client.svg)](https://pub.dev/packages/coinbase_cloud_advanced_trade_client)

A Dart client for the Coinbase Advanced Trade API. This package provides an easy-to-use interface for interacting with
the Coinbase Advanced Trade API, allowing you to manage your account, place orders, and get market data.

## Features

* **Accounts:** Get a list of your accounts and a single account's details.
* **Orders:** Create and cancel orders, and get a list of your orders.
* **Products:** Get a list of available products, a single product's details, and recent trades for a product.
* **Fills:** Get a list of your fills.

## Getting started

### Installation

To use this package, add `coinbase_cloud_advanced_trade_client` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  coinbase_cloud_advanced_trade_client: ^1.0.0 # Replace with the latest version
```

Then, run `dart pub get` or `flutter pub get`.

### API Keys

You will need to generate API keys from your Coinbase account.
You can find instructions on how to do this in
the [Coinbase documentation](https://docs.cdp.coinbase.com/coinbase-app/authentication-authorization/api-key-authentication).

> Note: Secret Keys are used as provided by Coinbase with the
> '\n' new line character breaks within the string.

### Credentials Object

All authenticated functions require a Credentials Object Passed in.
This allows for your code using the client to handle multiple accounts.

## Usage

Here is a simple example of how to use the client to get a list of products:

```dart
import 'package:coinbase_cloud_advanced_trade_client/coinbase_cloud_advanced_trade_client.dart';

void main() async {
  // Create a credential object with your API key and private key.
  // It is recommended to store these securely, for example, using environment variables.
  final credential = Credential(
    apiKeyName: 'YOUR_API_KEY_NAME',
    privateKeyPEM: 'YOUR_PRIVATE_KEY',
  );

  // Get a list of products.
  try {
    List<Product> products = await getProducts(credential: credential);
    for (var product in products) {
      print('Product: ${product.productId}, Price: ${product.price}');
    }
  } catch (e) {
    print('Error getting products: $e');
  }

  // Get a single product.
  try {
    Product? product = await getProduct(productId: 'BTC-USD', credential: credential);
    if (product != null) {
      print('Product: ${product.productId}, Price: ${product.price}');
    }
  } catch (e) {
    print('Error getting product: $e');
  }
}
```

For more detailed examples, please see the `example/` directory.

### Create an Order

Here is an example of how to create a limit order:

```dart
import 'package:coinbase_cloud_advanced_trade_client/coinbase_cloud_advanced_trade_client.dart';
import 'package:uuid/uuid.dart';

void main() async {
  // Create a credential object with your API key and private key.
  // It is recommended to store these securely, for example, using environment variables.
  final credential = Credential(
    apiKeyName: 'YOUR_API_KEY_NAME',
    privateKeyPEM: 'YOUR_PRIVATE_KEY',
  );

  // Create a unique client order ID.
  final clientOrderId = Uuid().v4();

  // Create a limit order.
  try {
    Map<String, dynamic>? result = await createLimitOrder(
      clientOrderId: clientOrderId,
      productId: 'BTC-USD',
      side: 'BUY',
      baseSize: '0.001',
      limitPrice: '10000.00',
      credential: credential,
    );
    if (result != null) {
      print('Order created successfully: $result');
    }
  } catch (e) {
    print('Error creating order: $e');
  }
}
```

## Additional information

### Coinbase Advanced Trade API Documentation

For more information about the Coinbase Advanced Trade API, please see the
official [Coinbase documentation](https://docs.cdp.coinbase.com/coinbase-app/advanced-trade-apis/overview).

### Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

### License

This package is licensed under the [Apache License 2.0](LICENSE).
