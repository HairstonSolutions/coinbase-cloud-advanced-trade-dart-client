import 'dart:convert';
import 'dart:io' show Platform;
import 'package:logging/logging.dart';
import '../../test_helpers.dart';
import '../../test_constants.dart' as testConstants;

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products/products.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'products_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('products_test');

  group('Test Get Products using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of products', () async {
      final mockResponse = {
        "products": [
          {
            "product_id": "BTC-USD",
            "price": "50000.00",
            "price_percentage_change_24h": "1.23",
            "volume_24h": "1000",
            "volume_percentage_change_24h": "4.56",
            "base_increment": "0.00000001",
            "quote_increment": "0.01",
            "quote_min_size": "1.00",
            "quote_max_size": "1000000.00",
            "base_min_size": "0.0001",
            "base_max_size": "1000",
            "base_name": "Bitcoin",
            "quote_name": "US Dollar",
            "watched": true,
            "is_disabled": false,
            "new": false,
            "status": "online",
            "cancel_only": false,
            "limit_only": false,
            "post_only": false,
            "trading_disabled": false,
            "auction_mode": false,
            "product_type": "SPOT",
            "quote_currency_id": "USD",
            "base_currency_id": "BTC",
            "fcm_trading_session_details": null,
            "mid_market_price": "50000.00"
          }
        ],
        "num_products": 1
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      List<Product?> products = await getProductsAuthorized(
          client: mockClient, credential: testConstants.credentials);

      expect(products, isNotNull);
      expect(products.length, 1);
      expect(products[0]?.productId, "BTC-USD");
    });

    test('Get a single product by ID', () async {
      final mockResponse = {
        "product_id": "BTC-USD",
        "price": "50000.00",
        "price_percentage_change_24h": "1.23",
        "volume_24h": "1000",
        "volume_percentage_change_24h": "4.56",
        "base_increment": "0.00000001",
        "quote_increment": "0.01",
        "quote_min_size": "1.00",
        "quote_max_size": "1000000.00",
        "base_min_size": "0.0001",
        "base_max_size": "1000",
        "base_name": "Bitcoin",
        "quote_name": "US Dollar",
        "watched": true,
        "is_disabled": false,
        "new": false,
        "status": "online",
        "cancel_only": false,
        "limit_only": false,
        "post_only": false,
        "trading_disabled": false,
        "auction_mode": false,
        "product_type": "SPOT",
        "quote_currency_id": "USD",
        "base_currency_id": "BTC",
        "fcm_trading_session_details": null,
        "mid_market_price": "50000.00"
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      Product? product = await getProductAuthorized(
          productId: "BTC-USD",
          client: mockClient,
          credential: testConstants.credentials);

      expect(product, isNotNull);
      expect(product?.productId, "BTC-USD");
    });
  });

  group('Test Get Products Requests to Coinbase AT API',
      skip: testConstants.ciSkip, () {
    test('Authorized Get Products', () async {
      String requestPath = '/products';
      var response = await getAuthorized(requestPath,
          credential: testConstants.credentials, isSandbox: false);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);

      expect(true, isTrue);
    });

    test('Authorized Get Products', () async {
      List<Product?> products = await getProductsAuthorized(
          credential: testConstants.credentials, isSandbox: false);
      logger.info('Products: $products');
      expect(products.isNotEmpty, true);
    });

    test('Get Product by Product ID', () async {
      String productId = 'ETH-USD';
      Product? product = await getProductAuthorized(
          productId: productId,
          credential: testConstants.credentials,
          isSandbox: false);

      logger.info('Product : $product');
      expect(product?.productId, productId);
    });

    test('Get Product by Product ID with getTradabilityStatus', () async {
      String productId = 'ETH-USD';
      Product? product = await getProductAuthorized(
          productId: productId,
          getTradabilityStatus: true,
          credential: testConstants.credentials,
          isSandbox: false);

      logger.info('Product : $product');
      expect(product?.productId, productId);
      expect(product?.viewOnly, isNotNull);
    });

    test('Get Product by Product ID II', () async {
      List<Product?> originProducts = await getProductsAuthorized(
          credential: testConstants.credentials, isSandbox: false);

      String? productId = originProducts.first?.productId;
      Product? product = await getProductAuthorized(
          productId: productId,
          credential: testConstants.credentials,
          isSandbox: false);

      logger.info('Product : $product');
      expect(product?.productId, productId);
    });
  });
}
