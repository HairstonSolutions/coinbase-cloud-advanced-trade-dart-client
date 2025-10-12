import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/product.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/products/products.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../mocks.mocks.dart';

// Use a dummy credential for mock tests
final Credential credentials =
    Credential(apiKeyName: 'api_key_name', privateKeyPEM: 'private_key');

void main() {
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

      List<Product?> products =
          await getProducts(client: mockClient, credential: credentials);

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

      Product? product = await getProduct(
          productId: "BTC-USD", client: mockClient, credential: credentials);

      expect(product, isNotNull);
      expect(product?.productId, "BTC-USD");
    });
  });
}