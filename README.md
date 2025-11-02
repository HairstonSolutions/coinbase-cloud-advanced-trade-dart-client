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
import 'package:coinbase_pro_sdk/coinbase_pro_sdk.dart';
  // Create a credential object with your Access key, Secret key and Pass Phrase.
  // It is recommended to store these securely, for example, using environment variables.
  final credential = Credential(
    accessKey: 'YOUR_ACCESS_KEY',
    secret: 'YOUR_SECRET_KEY',
    passphrase: 'PASSPHRASE',
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

### License

This package is licensed under the [Apache License 2.0](LICENSE).
