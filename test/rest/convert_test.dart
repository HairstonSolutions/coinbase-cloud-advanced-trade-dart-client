import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/convert.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_constants.dart';
import '../tools.dart';
import 'convert_test.mocks.dart';

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);

@GenerateMocks([http.Client])
void main() {
  group('Convert REST Tests', () {
    test('Create Convert Quote', () async {
      final client = MockClient();
      final String createConvertQuoteJson =
          await getJsonFromFile('test/rest/convert/create_convert_quote.json');

      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(createConvertQuoteJson, 200));

      final result = await createConvertQuote(
          client: client,
          credential: credentials,
          fromAccount: 'from',
          toAccount: 'to',
          amount: '100');

      expect(result, isNotNull);
      expect(result!.trade.id, isNotNull);
    });

    test('Commit Convert Trade', () async {
      final client = MockClient();
      final String commitConvertTradeJson = await getJsonFromFile(
          'test/rest/convert/commit_convert_trade.json');

      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(commitConvertTradeJson, 200));

      final result = await commitConvertTrade(
          client: client,
          credential: credentials,
          tradeId: '1234',
          fromAccount: 'from',
          toAccount: 'to',
          amount: '100');

      expect(result, isNotNull);
      expect(result!.id, isNotNull);
    });

    test('Get Convert Trade', () async {
      final client = MockClient();
      final String getConvertTradeJson =
          await getJsonFromFile('test/rest/convert/get_convert_trade.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(getConvertTradeJson, 200));

      final result = await getConvertTrade(
          client: client,
          credential: credentials,
          tradeId: '1234',
          fromAccount: 'from',
          toAccount: 'to');

      expect(result, isNotNull);
      expect(result!.id, isNotNull);
    });
  });
}
