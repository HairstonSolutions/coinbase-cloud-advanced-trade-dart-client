import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_preview_response.dart';
import 'package:decimal/decimal.dart';
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
      expect(response.slippage, Decimal.parse('0.1'));
      expect(response.orderTotal, Decimal.parse('100.0'));
      expect(response.commissionTotal, Decimal.parse('1.0'));
      expect(response.quoteSize, Decimal.parse('100.0'));
      expect(response.baseSize, Decimal.parse('1.0'));
      expect(response.bestBid, Decimal.parse('99.0'));
      expect(response.bestAsk, Decimal.parse('100.0'));
      expect(response.averageFilledPrice, Decimal.parse('100.0'));
    });

    test('parses empty strings and missing fields as null', () {
      final response = EditOrderPreviewResponse.fromCBJson({
        'slippage': '',
        'order_total': '',
        'commission_total': '',
        'quote_size': '',
        'base_size': '',
        'best_bid': '',
        'best_ask': '',
        'average_filled_price': '',
      });

      expect(response.errors, isNull);
      expect(response.slippage, isNull);
      expect(response.orderTotal, isNull);
      expect(response.commissionTotal, isNull);
      expect(response.quoteSize, isNull);
      expect(response.baseSize, isNull);
      expect(response.bestBid, isNull);
      expect(response.bestAsk, isNull);
      expect(response.averageFilledPrice, isNull);

      expect(EditOrderPreviewResponse.fromCBJson({}).orderTotal, isNull);
    });

    test('preserves precision that a double would lose', () {
      final response = EditOrderPreviewResponse.fromCBJson(
          {'order_total': '61250.10', 'commission_total': '0.45'});

      expect(response.orderTotal! + response.commissionTotal!,
          Decimal.parse('61250.55'));
    });
  });
}
