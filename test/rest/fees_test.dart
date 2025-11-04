import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/fees.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_constants.dart';
import '../tools.dart';
import 'fees_test.mocks.dart';

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);

@GenerateMocks([http.Client])
void main() {
  group('Fees REST Tests', () {
    test('Get Transaction Summary', () async {
      final client = MockClient();
      final String getTransactionSummaryJson = await getJsonFromFile(
          'test/rest/fees/get_transaction_summary.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(getTransactionSummaryJson, 200));

      final result =
          await getTransactionSummary(client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result!.totalFees, isNotNull);
    });
  });
}
