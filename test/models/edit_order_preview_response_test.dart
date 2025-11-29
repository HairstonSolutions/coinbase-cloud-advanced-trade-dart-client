import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_preview_response.dart';
import 'package:test/test.dart';

void main() {
  group('EditOrderPreviewResponse', () {
    test('parses from JSON correctly', () {
      final json = {
        'errors': [
          {
            'edit_failure_reason': 'some reason',
            'preview_failure_reason': 'some preview reason'
          }
        ],
        'slippage': '0.1',
        'order_total': '100.0',
        'commission_total': '1.0',
        'quote_size': '100.0',
        'base_size': '1.0',
        'best_bid': '99.0',
        'best_ask': '100.0',
        'average_filled_price': '100.0'
      };

      final response = EditOrderPreviewResponse.fromCBJson(json);

      expect(response.errors?.length, 1);
      expect(response.errors?.first.editFailureReason, 'some reason');
      expect(response.slippage, '0.1');
      expect(response.orderTotal, '100.0');
      expect(response.commissionTotal, '1.0');
      expect(response.quoteSize, '100.0');
      expect(response.baseSize, '1.0');
      expect(response.bestBid, '99.0');
      expect(response.bestAsk, '100.0');
      expect(response.averageFilledPrice, '100.0');
    });
  });
}
