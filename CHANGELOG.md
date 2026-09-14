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

- `Decimal` now types every price, size, balance, fee, increment and notional
  field in `Product`, `Order`, `Fill`, `Account`, `Ticker`, `Trade`,
  `PreviewOrderResponse`, `TransactionSummary`, `VolumeBreakdown`,
  `SpotPosition` and all five order configurations.
- `Order.numberOfFills` is now `int?`, matching what it actually is: a count.
- `getAccountBalance` returns `Future<Decimal?>`.
- `toJson()` / `toCBJson()` serialize decimals as strings, so payloads stay
  `jsonEncode`-able and round-trip without loss.
- `nullableDouble` has been removed. Use `nullableDecimal` for money and
  quantities, `nullableInt` for counts, or `nullableNumber` for non-monetary
  numbers such as epoch timestamps.
- Added `nullableDecimal`, `requiredDecimal` and `nullableInt` to
  `services/tools.dart`.
- Adds a `decimal: ^3.2.6` dependency.

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
