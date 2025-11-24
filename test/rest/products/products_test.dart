import 'dart:convert';
import 'dart:io';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('products_test');

  group('Test Get Products using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of products', () async {
      final String mockResponse =
          await getJsonFromFile('rest/products/get_products_authorized.json');

      when(mockClient.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      List<Product?> products = await getProductsAuthorized(
          client: mockClient, credential: constants.credentials);

      expect(products, isNotNull);
      expect(products.length, 1);
      expect(products[0]?.productId, "BTC-USD");
    });

    test('Get a single product by ID', () async {
      final String mockResponse =
          await getJsonFromFile('rest/products/get_product_authorized.json');

      when(mockClient.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      Product? product = await getProductAuthorized(
          productId: "BTC-USD",
          client: mockClient,
          credential: constants.credentials);

      expect(product, isNotNull);
      expect(product?.productId, "BTC-USD");
    });
  });

  group('Test Get Products Requests to Coinbase AT API', skip: constants.ciSkip,
      () {
    test('Authorized Get Products', () async {
      String requestPath = '/products';
      var response = await getAuthorized(requestPath,
          credential: constants.credentials, isSandbox: false);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);

      expect(true, isTrue);
    });

    test('Authorized Get Products', () async {
      List<Product?> products = await getProductsAuthorized(
          credential: constants.credentials, isSandbox: false);
      logger.info('Products: $products');
      expect(products.isNotEmpty, true);
    });

    test('Get Product by Product ID', () async {
      String productId = 'ETH-USD';
      Product? product = await getProductAuthorized(
          productId: productId,
          credential: constants.credentials,
          isSandbox: false);

      logger.info('Product : $product');
      expect(product?.productId, productId);
    });

    test('Get Product by Product ID with getTradabilityStatus', () async {
      String productId = 'ETH-USD';
      Product? product = await getProductAuthorized(
          productId: productId,
          getTradabilityStatus: true,
          credential: constants.credentials,
          isSandbox: false);

      logger.info('Product : $product');
      expect(product?.productId, productId);
      expect(product?.viewOnly, isNotNull);
    });

    test('Get Product by Product ID II', () async {
      List<Product?> originProducts = await getProductsAuthorized(
          credential: constants.credentials, isSandbox: false);

      String? productId = originProducts.first?.productId;
      Product? product = await getProductAuthorized(
          productId: productId,
          credential: constants.credentials,
          isSandbox: false);

      logger.info('Product : $product');
      expect(product?.productId, productId);
    });
  });
}
