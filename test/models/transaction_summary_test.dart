import 'package:coinbase_cloud_advanced_trade_client/src/models/transaction_summary.dart';
import 'package:test/test.dart';

void main() {
  group('TransactionSummary', () {
    test('throws FormatException when total_fees is missing', () {
      final json = {
        'total_volume': 1000.0,
        'fee_tier': {
          'pricing_tier': 'tier_1',
          'usd_from': '0',
          'usd_to': '10000',
          'taker_fee_rate': '0.005',
          'maker_fee_rate': '0.005'
        },
        'margin_rate': '0.01',
        'advanced_trade_only_volume': 1000.0,
        'advanced_trade_only_fees': 5.0,
        'coinbase_pro_volume': 0.0,
        'coinbase_pro_fees': 0.0,
        'total_balance': '1000',
        'volume_breakdown': []
      };

      expect(() => TransactionSummary.fromCBJson(json), throwsFormatException);
    });
  });
}
