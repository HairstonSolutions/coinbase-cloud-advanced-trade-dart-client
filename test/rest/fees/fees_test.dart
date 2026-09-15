import 'package:coinbase_cloud_advanced_trade_client/src/rest/fees.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

void main() {
  final Logger logger = setupLogger('fees_test');

  group('Fees REST Tests using Mocks', () {
    test('Get Transaction Summary', () async {
      final client = MockClient();
      final String getTransactionSummaryJson =
          await getJsonFromFile('rest/fees/get_transaction_summary.json');

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(getTransactionSummaryJson, 200));

      final result = await getTransactionSummary(
          client: client, credential: constants.credentials);

      expect(result, isNotNull);
      expect(result!.totalFees, isNotNull);
      expect(result.totalBalance, equals(Decimal.parse('61250.10')));
      expect(result.feeTier.takerFeeRate, equals(Decimal.parse('0.006')));
      expect(result.feeTier.makerFeeRate, equals(Decimal.parse('0.004')));
      expect(result.feeTier.aopFrom, equals(Decimal.zero));
      expect(result.feeTier.aopTo, equals(Decimal.parse('1000')));
      expect(result.feeTier.volumeTypesAndRange.first.volFrom,
          equals(Decimal.zero));
      expect(result.feeTier.volumeTypesAndRange.first.volTo,
          equals(Decimal.parse('10000')));
      expect(result.goodsAndServicesTax!.rate, equals(Decimal.parse('0.1')));

      // A fee-inclusive price is exact arithmetic, not a String parse.
      expect(Decimal.parse('100') * (Decimal.one + result.feeTier.takerFeeRate),
          equals(Decimal.parse('100.600')));
    });
  });

  group('Fees REST Tests Requests to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    test('Get Transaction Summary', () async {
      final result =
          await getTransactionSummary(credential: constants.credentials);

      logger.info('Fees: $result');

      expect(result, isNotNull);
      expect(result!.totalFees, isNotNull);
      expect(result.totalBalance, isA<Decimal>());
      expect(result.feeTier.takerFeeRate, isA<Decimal>());
      expect(result.feeTier.makerFeeRate, isA<Decimal>());
    });
  });
}
