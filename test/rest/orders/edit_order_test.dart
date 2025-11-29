import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_preview_response.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_response.dart';
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
        price: '100',
        size: '1',
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result.success, isTrue);
      expect(result.errors, isEmpty);
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
        price: '100',
        size: '1',
        credential: constants.credentials,
        client: mockClient,
      );

      expect(result.errors, isEmpty);
      expect(result.orderTotal, '100.0');
    });
  });
}
