import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/portfolio.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/portfolios.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'portfolios_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final mockClient = MockClient();
  final credential = Credential(
      apiKeyName: 'apiKey', privateKeyPEM: '''-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIC7MfY+wECbErLMx+7w87cWuAs6tdm505p9yGfEaxqVfoAoGCCqGSM49
AwEHoUQDQgAEoUiHOzjV7KODS686wHTYwY/gz5dvPKjVS/maWU+VKcuNBUvAc5hj
hSHpKl+DhF2u09WahshD18zlBVqFGO46Fg==
-----END EC PRIVATE KEY-----''');

  group('Portfolios API tests', () {
    test('listPortfolios returns a list of portfolios', () async {
      final response = {
        'portfolios': [
          {
            'uuid': 'uuid1',
            'name': 'portfolio1',
            'type': 'type1',
            'created_at': '2022-01-01T00:00:00Z',
            'deleted': false
          },
          {
            'uuid': 'uuid2',
            'name': 'portfolio2',
            'type': 'type2',
            'created_at': '2022-01-02T00:00:00Z',
            'deleted': false
          }
        ]
      };

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      final portfolios =
          await listPortfolios(client: mockClient, credential: credential);

      expect(portfolios, isA<List<Portfolio>>());
      expect(portfolios.length, 2);
    });

    test('createPortfolio returns a portfolio', () async {
      final response = {
        'portfolio': {
          'uuid': 'uuid1',
          'name': 'portfolio1',
          'type': 'type1',
          'created_at': '2022-01-01T00:00:00Z',
          'deleted': false
        }
      };

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      final portfolio = await createPortfolio(
          name: 'portfolio1', client: mockClient, credential: credential);

      expect(portfolio, isA<Portfolio>());
      expect(portfolio?.name, 'portfolio1');
    });

    test('getPortfolio returns a portfolio', () async {
      final response = {
        'portfolio': {
          'uuid': 'uuid1',
          'name': 'portfolio1',
          'type': 'type1',
          'created_at': '2022-01-01T00:00:00Z',
          'deleted': false
        }
      };

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      final portfolio = await getPortfolio(
          uuid: 'uuid1', client: mockClient, credential: credential);

      expect(portfolio, isA<Portfolio>());
      expect(portfolio?.uuid, 'uuid1');
    });

    test('editPortfolio returns a portfolio', () async {
      final response = {
        'portfolio': {
          'uuid': 'uuid1',
          'name': 'new name',
          'type': 'type1',
          'created_at': '2022-01-01T00:00:00Z',
          'deleted': false
        }
      };

      when(mockClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      final portfolio = await editPortfolio(
          uuid: 'uuid1',
          name: 'new name',
          client: mockClient,
          credential: credential);

      expect(portfolio, isA<Portfolio>());
      expect(portfolio?.name, 'new name');
    });

    test('deletePortfolio returns true', () async {
      when(mockClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('', 200));

      final result = await deletePortfolio(
          uuid: 'uuid1', client: mockClient, credential: credential);

      expect(result, true);
    });

    test('movePortfolioFunds returns true', () async {
      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 200));

      final result = await movePortfolioFunds(
          funds: {'currency': 'USD', 'value': '100'},
          sourcePortfolioUuid: 'source',
          targetPortfolioUuid: 'target',
          client: mockClient,
          credential: credential);

      expect(result, true);
    });
  });
}
