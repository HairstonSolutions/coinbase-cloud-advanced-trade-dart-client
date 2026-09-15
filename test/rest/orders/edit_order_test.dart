import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:decimal/decimal.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/orders/orders.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;

void main() {
  group('Edit Order', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('editOrder success', () async {
      final mockResponse = '{"success": true, "errors": []}';

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await editOrder(
        orderId: '123',
        price: Decimal.parse('100'),
        size: Decimal.parse('1'),
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result.success, isTrue);
      expect(result.errors, isEmpty);

      final body = jsonDecode(verify(mockClient.post(any,
              headers: anyNamed('headers'), body: captureAnyNamed('body')))
          .captured
          .single as String) as Map<String, dynamic>;
      expect(body['price'], '100');
      expect(body['size'], '1');
    });

    test('editOrder serializes Decimal price and size as plain strings',
        () async {
      final mockResponse = '{"success": true, "errors": []}';

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      await editOrder(
        orderId: '123',
        price: Decimal.parse('61250.10'),
        size: Decimal.parse('0.12345678'),
        credential: constants.credentials,
        client: mockClient,
      );

      final body = jsonDecode(verify(mockClient.post(any,
              headers: anyNamed('headers'), body: captureAnyNamed('body')))
          .captured
          .single as String) as Map<String, dynamic>;

      // Decimal normalizes trailing zeros: '61250.10' is sent as '61250.1'.
      expect(body['price'], '61250.1');
      expect(body['size'], '0.12345678');
    });

    test('editOrderPreview serializes Decimal price and size as plain strings',
        () async {
      final mockResponse = '{"errors": []}';

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      await editOrderPreview(
        orderId: '123',
        price: Decimal.parse('0.00001234'),
        size: Decimal.parse('1e21'),
        credential: constants.credentials,
        client: mockClient,
      );

      final body = jsonDecode(verify(mockClient.post(any,
              headers: anyNamed('headers'), body: captureAnyNamed('body')))
          .captured
          .single as String) as Map<String, dynamic>;

      // No exponent notation on either end of the range.
      expect(body['price'], '0.00001234');
      expect(body['size'], '1000000000000000000000');
    });

    test('editOrderPreview success', () async {
      final mockResponse = '''{
        "errors": [],
        "slippage": "0.1",
        "order_total": "100.0",
        "commission_total": "1.0",
        "quote_size": "100.0",
        "base_size": "1.0",
        "best_bid": "99.0",
        "best_ask": "100.0",
        "average_filled_price": "100.0"
      }''';

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await editOrderPreview(
        orderId: '123',
        price: Decimal.parse('100'),
        size: Decimal.parse('1'),
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result.errors, isEmpty);
      expect(result.orderTotal, '100.0');
    });

    test('editOrder failure', () async {
      final mockResponse = '{"error": "bad request"}';

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 400));

      expect(
          () async => await editOrder(
              orderId: '123',
              price: Decimal.parse('100'),
              size: Decimal.parse('1'),
              credential: constants.credentials,
              client: mockClient),
          throwsA(isA<CoinbaseException>()));
    });

    test('editOrderPreview failure', () async {
      final mockResponse = '{"error": "bad request"}';

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 400));

      expect(
          () async => await editOrderPreview(
              orderId: '123',
              price: Decimal.parse('100'),
              size: Decimal.parse('1'),
              credential: constants.credentials,
              client: mockClient),
          throwsA(isA<CoinbaseException>()));
    });
  });
}
