# Coinbase Advanced Trade API Client

[![pub version](https://img.shields.io/pub/v/coinbase_cloud_advanced_trade_client.svg)](https://pub.dev/packages/coinbase_cloud_advanced_trade_client)
[![CI](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/actions/workflows/ci.yml/badge.svg)](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/actions/workflows/ci.yml)

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
  coinbase_cloud_advanced_trade_client: ^0.10.0 # Replace with the latest version
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

### Money is never a `double`

Every monetary and quantity field — prices, sizes, balances, fees, fee rates,
increments and notionals — is typed as
[`Decimal`](https://pub.dev/packages/decimal), never `double`. Coinbase sends
these values as decimal strings, and this client keeps them exact all the way
to your code.

This matters because binary floating point cannot represent most decimal money
values. A balance of `61250.10` is not exactly representable as a `double`, and
`Product.baseIncrement` (`0.00000001`) and `quoteIncrement` (`0.01`) — the tick
sizes every order must be quantized to — cannot be used for exact quantization
once they have been through a `double`.

```dart
import 'package:decimal/decimal.dart';

final product = await getProduct(productId: 'BTC-USD');

// Exact tick quantization.
final increment = product!.baseIncrement!;          // Decimal('0.00000001')
final size = Decimal.parse('0.30000000');
final ticks = (size / increment).toDecimal();       // exactly 30000000

// Exact arithmetic; no drift.
final fees = Decimal.parse('12480.55') + Decimal.parse('0.45');  // 12481

// The spread and a fee-inclusive price are arithmetic, not String parsing.
final books = await getBestBidAsk(productIds: ['BTC-USD'], credential: credential);
final spread = books.first.asks.first.price - books.first.bids.first.price;

final summary = await getTransactionSummary(credential: credential);
final withFee = books.first.asks.first.price *
    (Decimal.one + summary!.feeTier.takerFeeRate);
```

Order inputs are `Decimal` too: `createMarketOrder`, `createLimitOrder`,
`createStopLimitOrderGTC`, `createStopLimitOrderGTD`, `editOrder` and
`editOrderPreview` take `Decimal` prices and sizes and serialize them to the
wire themselves, so a `double` formatted with `toStringAsFixed` or a localised
`'61,250.10'` cannot reach the API.

`Decimal` normalizes trailing zeros, so a wire value of `'61250.10'` parses to
`61250.1`, and `limitPrice: Decimal.parse('61250.10')` is sent as
`"limit_price":"61250.1"`. The value is preserved exactly; only its textual
form is normalized.

Integral fields stay integral: `Order.numberOfFills` is an `int`, and epoch
timestamps on `ServerTime` remain `num`.

If you need a `double` at the edge of your application — for charting or
display — convert explicitly with `.toDouble()`.

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

### Query Open Orders for a Specific Product

Here is an example of how to query open orders for a specific product using filters:

```dart
import 'package:coinbase_cloud_advanced_trade_client/coinbase_cloud_advanced_trade_client.dart';

void main() async {
  final credential = Credential(
    apiKeyName: 'YOUR_API_KEY_NAME',
    privateKeyPEM: 'YOUR_PRIVATE_KEY',
  );

  // Get a list of open orders for BTC-USD
  try {
    List<Order> orders = await getOrders(
      productIds: ['BTC-USD'],
      orderStatus: ['OPEN'],
      credential: credential,
    );
    for (var order in orders) {
      print('Order: ${order.orderId}, Status: ${order.status}, Side: ${order.side}');
    }
  } catch (e) {
    print('Error getting orders: $e');
  }
}
```

### Create an Order

Here is an example of how to create a limit order:

```dart
import 'package:coinbase_cloud_advanced_trade_client/coinbase_cloud_advanced_trade_client.dart';
import 'package:decimal/decimal.dart';
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
    CreateOrderResult result = await createLimitOrder(
      clientOrderId: clientOrderId,
      productId: 'BTC-USD',
      side: OrderSide.buy,
      baseSize: Decimal.parse('0.001'),
      limitPrice: Decimal.parse('10000.00'),
      credential: credential,
    );
    switch (result) {
      case OrderSuccess():
        print('Order created successfully: ${result.orderId}');
      case OrderRejected():
        print('Order rejected: ${result.reason} - ${result.message}');
    }
  } catch (e) {
    print('Error creating order: $e');
  }
}
```

### Configuring the base URL, timeout and http client

Every REST function takes an optional `CoinbaseHttpOptions`, which sets the
base URL, the request timeout and the `http.Client` used for the call. A custom
base URL is also what the request's JWT is signed against, so pointing the
client at a proxy or a local test server keeps authentication valid.

```dart
import 'package:coinbase_cloud_advanced_trade_client/coinbase_cloud_advanced_trade_client.dart';

void main() async {
  final credential = Credential(
    apiKeyName: 'YOUR_API_KEY_NAME',
    privateKeyPEM: 'YOUR_PRIVATE_KEY',
  );

  final options = CoinbaseHttpOptions(
    baseUrl: Uri.parse('http://localhost:8080'), // Optional; defaults to api.coinbase.com.
    timeout: const Duration(seconds: 10),
  );

  try {
    Page<Order> page = await getOrdersPage(
      productIds: ['BTC-USD'],
      credential: credential,
      options: options,
    );
    print('Fetched ${page.items.length} orders, hasNext: ${page.hasNext}');
  } on CoinbaseTimeoutException catch (e) {
    print('Request timed out: $e');
  }
}
```

### Handling network errors

Every failure the client raises is a `CoinbaseException`, so a single `on
CoinbaseException` clause covers API errors and network errors alike.

Requests that never reach Coinbase — a refused, reset or dropped connection, a
DNS failure, or a failed TLS handshake — throw a `CoinbaseTransportException`
carrying the request's `method` and `path` and the original
`http.ClientException`, `SocketException`, `HandshakeException` or
`TlsException` as its `cause`. A request that got no response in time still
throws `CoinbaseTimeoutException`. Both are `CoinbaseException` subclasses, so
a retry policy or circuit breaker can treat the two common transient failures
together without catching `package:http` or `dart:io` types.

```dart
try {
  Page<Order> page = await getOrdersPage(credential: credential);
  print('Fetched ${page.items.length} orders');
} on CoinbaseTimeoutException catch (e) {
  print('Timed out, retrying: $e');
} on CoinbaseTransportException catch (e) {
  print('Coinbase unreachable on ${e.method} ${e.path}: ${e.cause}');
} on CoinbaseException catch (e) {
  print('API error ${e.statusCode}: ${e.message}');
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
