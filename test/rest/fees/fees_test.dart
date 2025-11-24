import 'package:coinbase_cloud_advanced_trade_client/src/rest/fees.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

@GenerateMocks([http.Client])
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
    });
  });
}
