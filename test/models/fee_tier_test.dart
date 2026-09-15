import 'package:coinbase_cloud_advanced_trade_client/src/models/fee_tier.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  Map<String, dynamic> tierJson(
          {String aopTo = '1000', String volTo = '10000'}) =>
      {
        'pricing_tier': 'Advanced 1',
        'aop_from': '0',
        'aop_to': aopTo,
        'taker_fee_rate': '0.006',
        'maker_fee_rate': '0.004',
        'volume_types_and_range': [
          {
            'volume_types': ['ADVANCED_TRADE_SPOT'],
            'vol_from': '0',
            'vol_to': volTo,
          }
        ],
      };

  group('FeeTier', () {
    test('parses the rates and ranges as Decimal', () {
      final feeTier = FeeTier.fromCBJson(tierJson());

      expect(feeTier.takerFeeRate, equals(Decimal.parse('0.006')));
      expect(feeTier.makerFeeRate, equals(Decimal.parse('0.004')));
      expect(feeTier.aopFrom, equals(Decimal.zero));
      expect(feeTier.aopTo, equals(Decimal.parse('1000')));
      expect(feeTier.volumeTypesAndRange.single.volFrom, equals(Decimal.zero));
      expect(feeTier.volumeTypesAndRange.single.volTo,
          equals(Decimal.parse('10000')));
    });

    test('the fee rate is exact, so a fee-inclusive price is exact', () {
      final feeTier = FeeTier.fromCBJson(tierJson());

      expect(Decimal.parse('61700.00') * feeTier.takerFeeRate,
          equals(Decimal.parse('370.200')));
    });

    test('treats an empty upper bound as unbounded rather than throwing', () {
      final feeTier = FeeTier.fromCBJson(tierJson(aopTo: '', volTo: ''));

      expect(feeTier.aopTo, isNull);
      expect(feeTier.volumeTypesAndRange.single.volTo, isNull);
    });

    test('throws FormatException on an unparsable rate', () {
      final json = tierJson();
      json['taker_fee_rate'] = 'string';

      expect(() => FeeTier.fromCBJson(json), throwsFormatException);
    });
  });
}
