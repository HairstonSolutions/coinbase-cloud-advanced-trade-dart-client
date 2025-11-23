import 'dart:io';
import 'package:logging/logging.dart';
import '../../test_helpers.dart';
import '../../test_constants.dart';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/fees.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../test_constants.dart';
import '../../tools.dart';
import './fees_test.mocks.dart';

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

      final result =
          await getTransactionSummary(client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result!.totalFees, isNotNull);
    });
  });

  group('Fees REST Tests Requests to Coinbase AT API Endpoints', skip: ciSkip,
      () {
    test('Get Transaction Summary', () async {
      final result = await getTransactionSummary(credential: credentials);

      logger.info('Fees: $result');

      expect(result, isNotNull);
      expect(result!.totalFees, isNotNull);
    });
  });
}
