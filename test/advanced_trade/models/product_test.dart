import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/product.dart';
import 'package:test/test.dart';

import '../../tools.dart';

void main() {
  group('Test Fill Object Injection', () {
    String exampleProductJsonFile =
        'advanced_trade/models/examples/product.json';
    String? exampleProductJson;

    setUp(() async {
      exampleProductJson = await getJsonFromFile(exampleProductJsonFile);
    });

    test('Test Example Order JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleProductJson!);
      Product? exampleProduct = Product.convertJson(jsonAsMap);

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
  });
}
