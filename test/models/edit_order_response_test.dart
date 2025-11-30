import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_response.dart';
import 'package:test/test.dart';

void main() {
  group('EditOrderResponse', () {
    test('parses from JSON correctly', () {
      final json = {
        'success': true,
        'errors': [
          {
            'edit_failure_reason': 'some reason',
            'preview_failure_reason': 'some preview reason'
          }
        ]
      };

      final response = EditOrderResponse.fromCBJson(json);

      expect(response.success, isTrue);
      expect(response.errors?.length, 1);
      expect(response.errors?.first.editFailureReason, 'some reason');
      expect(
          response.errors?.first.previewFailureReason, 'some preview reason');
    });

    test('parses empty errors correctly', () {
      final json = {'success': true, 'errors': []};

      final response = EditOrderResponse.fromCBJson(json);

      expect(response.success, isTrue);
      expect(response.errors, isEmpty);
    });
  });
}
