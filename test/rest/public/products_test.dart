import 'package:coinbase_cloud_advanced_trade_client/src/rest/public/products.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_helpers.dart';
import '../../tools.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('public_products_test');

  group('Public Products using Mocks', () {
    test('Get Product', () async {
      final client = MockClient();
      final String productJson =
          await getJsonFromFile('rest/public/get_product.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productJson, 200));

      final product = await getProduct(productId: 'BTC-USD', client: client);

      expect(product, isNotNull);
      expect(product!.productId, 'BTC-USD');
    });

    test('Get Products', () async {
      final client = MockClient();
      final String productsJson =
          await getJsonFromFile('rest/public/get_products.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productsJson, 200));

      final products = await getProducts(client: client);

      expect(products, isNotNull);
      expect(products, isNotEmpty);
    });
  });

  group('Public REST Tests Requests to Coinbase AT API Endpoints', () {
    test('Get Product', () async {
      final product = await getProduct(productId: 'BTC-USD');

      logger.info('Product: $product');

      expect(product, isNotNull);
      expect(product!.productId, 'BTC-USD');
    });

    test('Get Products', () async {
      final products = await getProducts();

      logger.info('Products: $products');

      expect(products, isNotNull);
      expect(products, isNotEmpty);
    });
  });
}
