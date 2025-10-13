import 'dart:convert';
import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/fill.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/orders/fills.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/orders/orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../mocks.mocks.dart';

final Map<String, String> envVars = Platform.environment;
final String apiKeyName = envVars['COINBASE_API_KEY_NAME'] ?? 'api_key_name';
final String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];
final String? skipTests = envVars['SKIP_TESTS'];
final bool skip = skipTests == 'false' ? false : true;

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM!);

void main() {
  group('Test Get Fills using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of fills', () async {
      final mockResponse = {
        "fills": [
          {
            "entry_id": "22222-2222222-22222222",
            "trade_id": "123456",
            "order_id": "b0313b63-a2a1-4d30-a506-936337b52978",
            "trade_time": "2021-05-31T09:59:59Z",
            "trade_type": "FILL",
            "price": "50000.00",
            "size": "0.01",
            "commission": "0.50",
            "product_id": "BTC-USD",
            "sequence_timestamp": "2021-05-31T09:58:59.000Z",
            "liquidity_indicator": "TAKER",
            "size_in_quote": false,
            "user_id": "3333-333333-3333333",
            "side": "BUY",
            "retail_portfolio_id": "4444-444444-4444444",
            "fillSource": "FILL_SOURCE_UNKNOWN",
            "commission_detail_total": {
              "total_commission": "0.0",
              "gst_commission": "0.0",
              "withholding_commission": "0.0",
              "client_commission": "0.0"
            }
          }
        ],
        "cursor": "some-cursor-for-next-page"
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      List<Fill>? fills =
          await getFills(client: mockClient, credential: credentials);

      expect(fills, isNotNull);
      expect(fills.length, 1);
      expect(fills[0].orderId, "b0313b63-a2a1-4d30-a506-936337b52978");
    });
  });

  group('Test Get Fills Requests to Coinbase AT API Endpoints', skip: skip, () {
    test('Authorized Get All Fills', () async {
      String requestPath = '/orders/historical/fills';
      Map<String, dynamic>? queryParameters = {'limit': '1000'};
      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: credentials,
          isSandbox: false);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
      expect(true, isTrue);
    });

    test('Get all Fills as a list of Fills', () async {
      List<Fill>? fills =
          await getFills(credential: credentials, isSandbox: false);
      print('Fills: $fills');

      expect(fills.isNotEmpty, true);
    });

    test('Get all Fills by order ID', () async {
      List<Order>? orders =
          await getOrders(credential: credentials, isSandbox: false);
      String? orderId = orders.last.orderId;
      List<Fill>? fills = await getFills(
          orderId: orderId, credential: credentials, isSandbox: false);
      print('Fills: $fills');

      expect(fills.isNotEmpty, true);
      expect(fills.first.orderId, orderId);
    });

    test('Get all Fills by product ID', () async {
      List<Order>? orders =
          await getOrders(credential: credentials, isSandbox: false);
      String? productId = orders.last.productId;
      List<Fill>? fills = await getFills(
          productId: productId, credential: credentials, isSandbox: false);
      print('Fills: $fills');

      expect(fills.isNotEmpty, true);
      expect(fills.first.productId, productId);
    });
  });
}
