import 'package:coinbase_cloud_advanced_trade_client/src/models/transaction_summary.dart';
import 'package:decimal/decimal.dart';
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

    test('parses total_balance as a Decimal', () {
      final json = {
        'total_volume': 1000.0,
        'total_fees': 5.0,
        'fee_tier': {
          'pricing_tier': 'Advanced 1',
          'aop_from': '0',
          'aop_to': '1000',
          'taker_fee_rate': '0.006',
          'maker_fee_rate': '0.004',
          'volume_types_and_range': []
        },
        'margin_rate': '0.01',
        'advanced_trade_only_volume': 1000.0,
        'advanced_trade_only_fees': 5.0,
        'coinbase_pro_volume': 0.0,
        'coinbase_pro_fees': 0.0,
        'total_balance': '61250.10',
        'volume_breakdown': []
      };

      final summary = TransactionSummary.fromCBJson(json);

      expect(summary.totalBalance, equals(Decimal.parse('61250.10')));
      expect(summary.totalBalance - summary.totalFees,
          equals(Decimal.parse('61245.10')));
    });

    test('throws FormatException when total_balance is unparsable', () {
      final json = {
        'total_volume': 1000.0,
        'total_fees': 5.0,
        'fee_tier': {
          'pricing_tier': 'Advanced 1',
          'aop_from': '0',
          'aop_to': '1000',
          'taker_fee_rate': '0.006',
          'maker_fee_rate': '0.004',
          'volume_types_and_range': []
        },
        'margin_rate': '0.01',
        'advanced_trade_only_volume': 1000.0,
        'advanced_trade_only_fees': 5.0,
        'coinbase_pro_volume': 0.0,
        'coinbase_pro_fees': 0.0,
        'total_balance': 'string',
        'volume_breakdown': []
      };

      expect(() => TransactionSummary.fromCBJson(json), throwsFormatException);
    });
  });
}
