import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/product.dart';
import 'package:test/test.dart';

import '../../tools.dart';

void main() {
  group('Test Fill Object Injection', () {
    String exampleProductJsonFile =
        'advanced_trade/models/examples/product.json';
    String? exampleProductCBJson;

    setUp(() async {
      exampleProductCBJson = await getJsonFromFile(exampleProductJsonFile);
    });

    test('Test Example Order JSON Import Object conversion', () {
      var cbJsonAsMap = jsonDecode(exampleProductCBJson!);
      Product? exampleProduct = Product.fromCBJson(cbJsonAsMap);

      print('Product Object: $exampleProduct');

      expect(exampleProduct.productId, 'BTC-USD');
      expect(exampleProduct.price, 140.21);
      expect(exampleProduct.pricePercentageChange24h, "9.43%");
      expect(exampleProduct.volume24h, 1908432);
      expect(exampleProduct.volumePercentageChange24h, "9.43%");
      expect(exampleProduct.baseIncrement, 0.00000001);
      expect(exampleProduct.quoteIncrement, 0.00000001);
      expect(exampleProduct.quoteMinSize, 0.00000001);
      expect(exampleProduct.quoteMaxSize, 1000);
      expect(exampleProduct.baseName, "Bitcoin");
      expect(exampleProduct.quoteName, "US Dollar");
      expect(exampleProduct.watched, true);
      expect(exampleProduct.isDisabled, false);
      expect(exampleProduct.isNew, true);
      expect(exampleProduct.status, "string");
      expect(exampleProduct.cancelOnly, true);
      expect(exampleProduct.limitOnly, true);
      expect(exampleProduct.postOnly, true);
      expect(exampleProduct.tradingDisabled, false);
      expect(exampleProduct.auctionMode, true);
      expect(exampleProduct.productType, "UNKNOWN_PRODUCT_TYPE");
      expect(exampleProduct.quoteCurrencyId, "USD");
      expect(exampleProduct.baseCurrencyId, "BTC");
      expect(exampleProduct.midMarketPrice, 140.22);
    });

    test('Example Order JSON Import, Serialize, deserialize', () {
      var cbJsonAsMap = jsonDecode(exampleProductCBJson!);
      Product exampleProduct = Product.fromCBJson(cbJsonAsMap);
      var serializedProduct = exampleProduct.toJson();

      Product deserializedProduct = Product.fromJson(serializedProduct);

      print('Deserialized Product Object: $deserializedProduct');

      expect(deserializedProduct.productId, 'BTC-USD');
      expect(deserializedProduct.price, 140.21);
      expect(deserializedProduct.pricePercentageChange24h, "9.43%");
      expect(deserializedProduct.volume24h, 1908432);
      expect(deserializedProduct.volumePercentageChange24h, "9.43%");
      expect(deserializedProduct.baseIncrement, 0.00000001);
      expect(deserializedProduct.quoteIncrement, 0.00000001);
      expect(deserializedProduct.quoteMinSize, 0.00000001);
      expect(deserializedProduct.quoteMaxSize, 1000);
      expect(deserializedProduct.baseName, "Bitcoin");
      expect(deserializedProduct.quoteName, "US Dollar");
      expect(deserializedProduct.watched, true);
      expect(deserializedProduct.isDisabled, false);
      expect(deserializedProduct.isNew, true);
      expect(deserializedProduct.status, "string");
      expect(deserializedProduct.cancelOnly, true);
      expect(deserializedProduct.limitOnly, true);
      expect(deserializedProduct.postOnly, true);
      expect(deserializedProduct.tradingDisabled, false);
      expect(deserializedProduct.auctionMode, true);
      expect(deserializedProduct.productType, "UNKNOWN_PRODUCT_TYPE");
      expect(deserializedProduct.quoteCurrencyId, "USD");
      expect(deserializedProduct.baseCurrencyId, "BTC");
      expect(deserializedProduct.midMarketPrice, 140.22);

      print('Serialized Product: ${jsonEncode(deserializedProduct)}');
    });
  });
}
