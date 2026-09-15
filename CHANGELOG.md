# 0.10.0

**Breaking:** Monetary and quantity fields are now `Decimal` (from
[`package:decimal`](https://pub.dev/packages/decimal)) instead of `double`.
Fixes [#91](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/91).

Coinbase sends prices, sizes, balances, fees and increments as decimal strings.
Parsing them into IEEE `double` lost precision before the caller ever saw the
value, and there was no way to opt out. `Product.baseIncrement` and
`quoteIncrement` — the tick sizes every order must be quantized to — could not
be used for exact quantization, and balances such as `61250.10` drifted under
arithmetic.

- `Decimal` now types every price, size, balance, fee, fee rate, increment and
  notional field in `Product`, `Order`, `Fill`, `Account`, `Ticker`, `Trade`,
  `PreviewOrderResponse`, `TransactionSummary`, `VolumeBreakdown`,
  `SpotPosition` and all five order configurations, and — as of
  [#112](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/112)
  — in `PriceLevel`, `FeeTier`, `VolumeTypesAndRange`, `GoodsAndServicesTax`,
  `Candle`, `Money`, `PerpPosition` and `FuturesPosition`. No `String` price,
  size, rate or balance field remains under `lib/src/models`.
- `Order.numberOfFills` is now `int?`, matching what it actually is: a count.
- `FeeTier.aopTo` and `VolumeTypesAndRange.volTo` are `Decimal?`. Coinbase sends
  an empty string for the highest tier, which has no upper bound; that now
  parses to `null` rather than throwing.
- The two order **preview** responses are `Decimal` throughout.
  Fixes [#123](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/123).
  `EditOrderPreviewResponse` had been missed entirely and `PreviewOrderResponse`
  was only half-converted, so `previewOrder` and `editOrderPreview` — the two
  calls whose whole job is to answer "what will this cost me?" — handed back
  `String` totals the caller had to run through `double.parse` to use.
  `slippage`, `orderTotal`, `commissionTotal`, `bestBid`, `bestAsk` and
  `averageFilledPrice` on `EditOrderPreviewResponse`, and `orderTotal`,
  `commissionTotal`, `bestBid`, `bestAsk`, `orderMarginTotal`, `slippage`,
  `currentLiquidationBuffer`, `projectedLiquidationBuffer` and
  `estAverageFilledPrice` on `PreviewOrderResponse`, are now `Decimal?`. The
  leverage multipliers (`leverage`, `longLeverage`, `shortLeverage`,
  `maxLeverage`) are `Decimal?` too — they are not money, but they are decimal
  strings on the wire. `max_leverage` comes back as an empty string on spot
  previews, which parses to `null` rather than throwing.
- Order creation and edit **inputs** are `Decimal` too, so the API is symmetric
  in both directions.
  Fixes [#111](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/111).
  `createMarketOrder` (`quoteSize`, `baseSize`), `createLimitOrder` and
  `createStopLimitOrderGTC` / `createStopLimitOrderGTD` (`baseSize`,
  `limitPrice`, `stopPrice`) and `editOrder` / `editOrderPreview` (`price`,
  `size`) took `String`, so a `Decimal` had to be stringified by the caller and
  nothing stopped `limitPrice: price.toStringAsFixed(2)` on a `double`, or a
  localised `'61,250.10'`, from reaching Coinbase. The package now serializes
  these with `Decimal.toString()`, which never emits an exponent or a grouping
  separator. No `String` price or size parameter remains on the order-creation
  and edit functions.
- `getAccountBalance` returns `Future<Decimal?>`.
- `toJson()` / `toCBJson()` serialize decimals as strings, so payloads stay
  `jsonEncode`-able and round-trip without loss.
- `nullableDouble` has been removed. Use `nullableDecimal` for money and
  quantities, `nullableInt` for counts, or `nullableNumber` for non-monetary
  numbers such as epoch timestamps.
- Added `nullableDecimal`, `requiredDecimal` and `nullableInt` to
  `services/tools.dart`.
- Adds a `decimal: ^3.2.6` dependency.

### Added

- `CoinbaseHttpOptions` (base URL, timeout, http client) is now accepted by
  every public REST function as an optional `options` parameter and forwarded
  to the network layer.
  Fixes [#107](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/107).
  Previously only the low-level helpers in `services/network.dart` took it, so
  the base URL override and the request timeout were unreachable through the
  package's public API. A custom `baseUrl` is also what the JWT `uri` claim is
  signed with, which wrapping the `http.Client` cannot do.

```dart
final options = CoinbaseHttpOptions(
  baseUrl: Uri.parse('http://localhost:8080'),
  timeout: const Duration(seconds: 10),
);

final page = await getOrdersPage(credential: credential, options: options);
```

- `CoinbaseException` and `CoinbaseTimeoutException` are now exported from the
  library, so a caller configuring a timeout can catch them without importing
  `src/`.

- `CoinbaseTransportException`, a `CoinbaseException` subclass thrown when a
  request never produced a response.
  Fixes [#109](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/109).
  The transport mapped a timeout to `CoinbaseTimeoutException` but let every
  other network failure escape raw, so callers had to catch `package:http` and
  `dart:io` types from inside the library to tell "the exchange was
  unreachable" apart from a programming error, and a dropped connection went
  unhandled by code that caught only `CoinbaseException`.
  `http.ClientException`, `SocketException`, `HandshakeException` and
  `TlsException` are now wrapped in it at the same point the timeout is mapped,
  carrying the request's `method` and `path` and the original error as `cause`.
  Its `statusCode` is `0`, since no response was received. Timeout behaviour is
  unchanged.

```dart
try {
  Page<Order> page = await getOrdersPage(credential: credential);
} on CoinbaseTimeoutException catch (e) {
  print('Timed out: $e');
} on CoinbaseTransportException catch (e) {
  print('Coinbase unreachable on ${e.method} ${e.path}: ${e.cause}');
}
```

### Fixed

- `Account.fromJson` threw `type 'Null' is not a subtype of type 'String'` when
  `createdAt`, `updatedAt` or `deletedAt` was null. Since `deletedAt` is null
  for every account that has not been deleted, round-tripping a live account
  through `toJson()` / `fromJson()` always threw. All three are now null-guarded,
  matching `fromCBJson`.
- The order enums' `fromCB` threw `type 'Null' is not a subtype of type 'String'`
  on a payload that omitted the field, so `Order.fromCBJson` could not parse an
  order without `trigger_status`, `order_type`, `reject_reason` or
  `product_type`. `OrderSide`, `OrderStatus`, `OrderType`, `ProductType`,
  `RejectReason`, `TimeInForce`, `TriggerStatus` and `StopDirection` now accept
  a null value and return their unknown/unspecified member, matching the
  existing behaviour for an unrecognised string.
- `getOrder`, `getProduct` and `getProductAuthorized` declare a nullable return
  type but threw `CoinbaseException` on a `404`, so the `null` branch their
  signatures promise was dead code and "does this order exist?" had to be
  answered by catching the exception and inspecting `statusCode`.
  Fixes [#110](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/110).
  All three now return `null` on a `404` and keep throwing `CoinbaseException`
  on every other non-200 response.

```dart
final Order? order = await getOrder(
  orderId: 'an-order-that-may-not-exist',
  credential: credential,
);

if (order == null) {
  // Coinbase has no such order — a 500 or a 401 still throws.
}
```

### Internal

- GitHub Actions CI runs `dart format`, `dart analyze --fatal-infos
  --fatal-warnings` and `dart test` on every pull request and every push to
  `main`, and validates the package with `dart pub publish --dry-run` on `v*`
  tags.
  Fixes [#113](https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/113).
  Until now nothing ran outside a contributor's machine, so a regression in
  parsing or signing could be tagged without any automated gate.
- `getFills` now merges the deprecated `orderId` and `productId` filters into
  `orderIds` and `productIds` itself rather than forwarding them to
  `getFillsPage`, which clears the `deprecated_member_use_from_same_package`
  infos that `--fatal-infos` would have failed on. The request it sends is
  unchanged.

### Migrating

```dart
// Before
final double? price = product.price;
final double total = order.filledSize! * order.averageFilledPrice!;

// After
final Decimal? price = product.price;
final Decimal total = order.filledSize! * order.averageFilledPrice!;

// Need a double at the edge of your app (display, charting)?
final double asDouble = product.price!.toDouble();

// Before — the two values you most need arithmetic on were left for you to parse.
final spread = double.parse(book.asks.first.price) -
    double.parse(book.bids.first.price);
final withFee = double.parse(summary.feeTier.takerFeeRate) * price;

// After
final Decimal spread = book.asks.first.price - book.bids.first.price;
final Decimal withFee = summary.feeTier.takerFeeRate * price;

// The unbounded top fee tier is now null rather than an empty string.
final Decimal? aopTo = summary.feeTier.aopTo;

// Before — order inputs were Strings.
await createLimitOrder(
  clientOrderId: clientOrderId,
  productId: 'BTC-USD',
  side: OrderSide.buy,
  baseSize: '0.12345678',
  limitPrice: '61250.10',
  credential: credential,
);

// After — pass the Decimal straight through; the package serializes it.
await createLimitOrder(
  clientOrderId: clientOrderId,
  productId: 'BTC-USD',
  side: OrderSide.buy,
  baseSize: Decimal.parse('0.12345678'),  // sent as "0.12345678"
  limitPrice: Decimal.parse('61250.10'),  // sent as "61250.1"
  credential: credential,
);
```

Note that `Decimal` normalizes trailing zeros: a wire value of `'61250.10'`
parses to the exact value `61250.1`. The value is preserved exactly; only its
textual form is normalized.

# 0.9.0

- Implement Preview Orders Endpoint (`POST /v3/brokerage/orders/preview`)
- Implement Edit Order Endpoint (`POST /v3/brokerage/orders/edit`)
- Implement Edit Order Preview Endpoint (`POST /v3/brokerage/orders/edit_preview`)
- Implement List Payment Methods Endpoint (`GET /v3/brokerage/payment_methods`)
- Implement Get Payment Method Endpoint (`GET /v3/brokerage/payment_methods/{payment_method_id}`)
- Add `PaymentMethod` model and exports
- ⚡ Performance: Optimize `convertParamsToString` with `Iterable.join()`
- ⚡ Performance: Optimize `getAccountByCurrency` search with `indexWhere`
- Add BTC Price Example (`example/get_btc_price_example.dart`)
- Add Market Order Example (`example/market_order_example.dart`)
- Security: Bump `jose` to `^0.3.5+2` to resolve GHSA-vm9r-h74p-hg97
- Update `lints` to `^6.1.0`

# 0.8.0

- Implement Get Best Bid Ask
- Implement Get Market Trades Public Endpoint
- Implement Orders Close Position for given Product ID (Futures)
- Implement Batch Cancel Orders
- Implement Orders Stop Limit GTC(Good Till Cancelled)
- Implement Orders Stop Limit GTD(Good Till Date)
- Static Order Enums for constructing Order configurations

## 0.7.0

- Implement Fees / Transaction Summary
- Implement Data API: Get API Key Permissions
- Implement Public: Get Server Time
- Tool: Network Call to Coinbase API for Public endpoints
- Implement Public: Get Product
- Implement Public: Get Products List
- Implement Get Product Book (Public & Authorized)
- Implement Get Product Candles (Public & Authorized)

## 0.6.1

- Remove Coinbase Pro Support
- Implement Portfolios CRUD
- Implement Get Portfolio Breakdown Endpoint

## 0.5.0

- Implement `POST /v3/brokerage/orders` - Create Order
- Add Mockito testing for Advanced Trade REST services
- Refactor tests to use mocks instead of live data

## 0.4.0

- Pub.dev preparations
- First Published pub.dev version
- Migrate Auth to Coinbase AT API Key Version 2
- Generate Coinbase JWT Token with key signature
- Refactor Credential to v2
- Update Sandbox URL
- Remove Accepted Environment Variable "COINBASE_API_KEY"
- Remove Accepted Environment Variable "COINBASE_API_SECRET"
- Introduce new Environment Variable "COINBASE_API_KEY_NAME"
- Introduce new Environment Variable "COINBASE_PRIVATE_KEY"

## 0.3.0

- Upgrade to Dart 3.3.0

## 0.2.2

- Bug Fix: Coinbase Pro Fill Model CB JSON Conversion for USD Volume

## 0.2.1

- Native JSON Serialization / Deserialization of AT model objects

## 0.2.0

- Rename to "coinbase_cloud_advanced_trade_client"
- Primary Support for Advanced Trade API
- Pro Exchange is now secondary
- Get Account Details
- Get Orders, Order-Fills
- Get Products
- Get Product Market Trades

## 0.1.1

- Signature Support for Advanced Trade API.
- Get All Accounts

## 0.0.1

- Initial version.
- Coinbase Pro API Support.
- Get Accounts
- Create Orders
- Get Orders
- Get Fills
- Get Fees
- Signature Support for Coinbase Pro API Authenticated requests
- Get Ticker (Price bid/ask amounts)
