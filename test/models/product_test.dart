import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../test_helpers.dart';
import '../tools.dart';

void main() {
  final Logger logger = setupLogger('product_test');

  group('Test Product Object Injection', () {
    String exampleProductJsonFile = 'models/examples/product.json';
    String? exampleProductCBJson;

    setUp(() async {
      exampleProductCBJson = await getJsonFromFile(exampleProductJsonFile);
    });

    test('Test Example Product JSON Import Object conversion', () {
      var cbJsonAsMap = jsonDecode(exampleProductCBJson!);
      Product? exampleProduct = Product.fromCBJson(cbJsonAsMap);

      logger.info('Product Object: $exampleProduct');

      expect(exampleProduct.productId, 'BTC-USD');
      expect(exampleProduct.price, 43423.01);
      expect(exampleProduct.pricePercentageChange24h, '0.45');
      expect(exampleProduct.volume24h, 12345.67);
      expect(exampleProduct.volumePercentageChange24h, '2.34');
      expect(exampleProduct.baseIncrement, 0.00000001);
      expect(exampleProduct.quoteIncrement, 0.01);
      expect(exampleProduct.quoteMinSize, 1.00);
      expect(exampleProduct.quoteMaxSize, 1000000.00);
      expect(exampleProduct.baseMinSize, 0.0001);
      expect(exampleProduct.baseMaxSize, 200);
      expect(exampleProduct.baseName, 'Bitcoin');
      expect(exampleProduct.quoteName, 'US Dollar');
      expect(exampleProduct.watched, false);
      expect(exampleProduct.isDisabled, false);
      expect(exampleProduct.isNew, false);
      expect(exampleProduct.status, 'online');
      expect(exampleProduct.cancelOnly, false);
      expect(exampleProduct.limitOnly, false);
      expect(exampleProduct.postOnly, false);
      expect(exampleProduct.tradingDisabled, false);
      expect(exampleProduct.auctionMode, false);
      expect(exampleProduct.productType, 'SPOT');
      expect(exampleProduct.quoteCurrencyId, 'USD');
      expect(exampleProduct.baseCurrencyId, 'BTC');
      expect(exampleProduct.midMarketPrice, 43423.00);
      expect(exampleProduct.alias, '');
      expect(exampleProduct.aliasTo, []);
      expect(exampleProduct.baseDisplaySymbol, 'BTC');
      expect(exampleProduct.quoteDisplaySymbol, 'USD');
      expect(exampleProduct.viewOnly, false);
      expect(exampleProduct.priceIncrement, 0.01);
      expect(exampleProduct.displayName, 'BTC/USD');
      expect(exampleProduct.productVenue, 'CBE');
      expect(exampleProduct.approximateQuote24hVolume, 536000000);
      expect(exampleProduct.newAt, DateTime.parse('2023-01-01T00:00:00Z'));
      expect(exampleProduct.marketCap, 850000000000);
    });

    test('Example Product JSON Import, Serialize, deserialize', () {
      var cbJsonAsMap = jsonDecode(exampleProductCBJson!);
      Product exampleProduct = Product.fromCBJson(cbJsonAsMap);
      var serializedProduct = exampleProduct.toJson();

      Product deserializedProduct = Product.fromJson(serializedProduct);

      logger.info('Deserialized Product Object: $deserializedProduct');

      expect(deserializedProduct.productId, 'BTC-USD');
      expect(deserializedProduct.price, 43423.01);
      expect(deserializedProduct.pricePercentageChange24h, '0.45');
      expect(deserializedProduct.volume24h, 12345.67);
      expect(deserializedProduct.volumePercentageChange24h, '2.34');
      expect(deserializedProduct.baseIncrement, 0.00000001);
      expect(deserializedProduct.quoteIncrement, 0.01);
      expect(deserializedProduct.quoteMinSize, 1.00);
      expect(deserializedProduct.quoteMaxSize, 1000000.00);
      expect(deserializedProduct.baseMinSize, 0.0001);
      expect(deserializedProduct.baseMaxSize, 200);
      expect(deserializedProduct.baseName, 'Bitcoin');
      expect(deserializedProduct.quoteName, 'US Dollar');
      expect(deserializedProduct.watched, false);
      expect(deserializedProduct.isDisabled, false);
      expect(deserializedProduct.isNew, false);
      expect(deserializedProduct.status, 'online');
      expect(deserializedProduct.cancelOnly, false);
      expect(deserializedProduct.limitOnly, false);
      expect(deserializedProduct.postOnly, false);
      expect(deserializedProduct.tradingDisabled, false);
      expect(deserializedProduct.auctionMode, false);
      expect(deserializedProduct.productType, 'SPOT');
      expect(deserializedProduct.quoteCurrencyId, 'USD');
      expect(deserializedProduct.baseCurrencyId, 'BTC');
      expect(deserializedProduct.midMarketPrice, 43423.00);
      expect(deserializedProduct.alias, '');
      expect(deserializedProduct.aliasTo, []);
      expect(deserializedProduct.baseDisplaySymbol, 'BTC');
      expect(deserializedProduct.quoteDisplaySymbol, 'USD');
      expect(deserializedProduct.viewOnly, false);
      expect(deserializedProduct.priceIncrement, 0.01);
      expect(deserializedProduct.displayName, 'BTC/USD');
      expect(deserializedProduct.productVenue, 'CBE');
      expect(deserializedProduct.approximateQuote24hVolume, 536000000);
      expect(deserializedProduct.newAt, DateTime.parse('2023-01-01T00:00:00Z'));
      expect(deserializedProduct.marketCap, 850000000000);

      logger.info('Serialized Product: ${jsonEncode(deserializedProduct)}');
    });
  });
}
