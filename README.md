# Coinbase Pro API Client

[![pub version](https://img.shields.io/pub/v/coinbase_pro_sdk.svg)](https://pub.dev/packages/coinbase_pro_sdk)

An Unofficial Dart client for the Coinbase Pro API. This package provides an easy-to-use interface for interacting with
the Coinbase Pro API, allowing you to manage your account, place orders, and get market data.

This SDK is not supported by Coinbase Inc.

## Features

* **Accounts:** Get a list of your accounts and a single account's details.
* **Orders:** Create and cancel orders, and get a list of your orders.
* **Products:** Get a list of available products, a single product's details, and recent trades for a product.
* **Fills:** Get a list of your fills.

## Getting started

### Installation

To use this package, add `coinbase_pro_sdk` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  coinbase_pro_sdk: ^1.0.0 # Replace with the latest version
```

Then, run `dart pub get` or `flutter pub get`.

### API Keys

This SDK uses the Legacy API Access Key, Secret and Pass Phrase to
authenticate against the Coinbase Pro API. These keys can no longer be generated.
This SDK will only work with Existing Legacy Credentials.

> Warning: Coinbase may decide at any moment to no longer allow the
> use of these Legacy keys as they already have a modern replacement.

If you do not have an existing Key, then we recommend that you use the
[coinbase_cloud_advanced_trade_client](https://pub.dev/packages/coinbase_cloud_advanced_trade_client)
dart package instead. Then you can generate a modern API Key following the
official coinbase documentation:
[Coinbase documentation](https://docs.cdp.coinbase.com/coinbase-app/authentication-authorization/api-key-authentication).

### Credentials Object

All authenticated functions require a Credentials Object Passed in.
This allows for your code using the client to handle multiple accounts.

There are some endpoints that do not require authentication. These
endpoints do not need the Credentials Object passed into them.

## Usage

### Get Products

Here is a simple example of how to use the client to get a list of products:


```dart
import 'package:coinbase_pro_sdk/pro.dart';

  // Get a list of products.
  try {
    List<Product> products = await getProducts(credential: credential);
    for (var product in products) {
      print('Product: ${product.displayName}');
    }
  } catch (e) {
    print('Error getting products: $e');
  }

  // Get a single product.
  try {
    Product? product = await getProduct(productId: 'BTC-USD', credential: credential);
    if (product != null) {
      print('Product: ${product}');
    }
  } catch (e) {
    print('Error getting product: $e');
  }
}
```

### Get Orders

Here is a simple example of how to use the client to get a list of orders:

```dart
import 'package:coinbase_pro_sdk/pro.dart';

void main() async {
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
```

For more detailed examples, please see the `example/` directory.

### License

This package is licensed under the [Apache License 2.0](LICENSE).
