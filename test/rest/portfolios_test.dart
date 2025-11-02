import 'dart:convert';
import 'dart:io';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/portfolio.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/portfolio_breakdown.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/portfolios.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../portfolios_test.mocks.dart';
import '../test_constants.dart' as constants;

final Map<String, String> envVars = Platform.environment;
final String? skipTests = envVars['SKIP_TESTS'];
final bool skip = skipTests == 'false' ? false : true;
final String? skipDestructiveTests = envVars['SKIP_DESTRUCTIVE_TESTS'];
final bool skipDT = skipTests == 'false' ? false : true;

final String portfolioCreateName =
    envVars['PORTFOLIO_CREATE_NAME'] ?? 'portfolioTDD1';
final String portfolioGetUUID = envVars['PORTFOLIO_GET_UUID'] ??
    '88888888-4444-4444-4444-121212121212';
final String portfolioBreakdownGetUUID =
    envVars['PORTFOLIO_BREAKDOWN_GET_UUID'] ??
        '88888888-4444-4444-4444-121212121212';
final String portfolioDeleteUUID =
    envVars['PORTFOLIO_DELETE_UUID'] ?? '88888888-4444-4444-4444-121212121212';
final String portfolioEditUUID =
    envVars['PORTFOLIO_EDIT_UUID'] ?? '88888888-4444-4444-4444-121212121212';
final String portfolioEditNewName =
    envVars['PORTFOLIO_EDIT_NEW_NAME'] ?? 'portfolioTDD2';
final String portfolioMoveFundsSourceUUID =
    envVars['PORTFOLIO_MOVE_FUNDS_SOURCE_UUID'] ??
        '88888888-4444-4444-4444-121212121212';
final String portfolioMoveFundsTargetUUID =
    envVars['PORTFOLIO_MOVE_FUNDS_TARGET_UUID'] ??
        '88888888-4444-4444-4444-121212121212';

@GenerateMocks([http.Client])
void main() {
  final mockClient = MockClient();
  final credential = Credential(
      apiKeyName: constants.apiKeyName, privateKeyPEM: constants.privateKeyPEM);

  group('Portfolios API tests using Mocks', () {
    test('listPortfolios returns a list of portfolios', () async {
      final response = {
        'portfolios': [
          {
            'uuid': 'uuid1',
            'name': 'portfolio1',
            'type': 'type1',
            'deleted': false
          },
          {
            'uuid': 'uuid2',
            'name': 'portfolio2',
            'type': 'type2',
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

    test('editPortfolio returns a portfolio', () async {
      final response = {
        'portfolio': {
          'uuid': 'uuid1',
          'name': 'new name',
          'type': 'type1',
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

    test('getPortfolioBreakdown returns a portfolio breakdown', () async {
      final response = {
        'breakdown': {
          'portfolio': {
            'uuid': 'uuid1',
            'name': 'portfolio1',
            'type': 'type1',
            'deleted': false
          },
          'portfolio_balances': {
            'total_balance': {'value': '100', 'currency': 'USD'},
            'total_futures_balance': {'value': '100', 'currency': 'USD'},
            'total_cash_equivalent_balance': {
              'value': '100',
              'currency': 'USD'
            },
            'total_crypto_balance': {'value': '100', 'currency': 'USD'},
            'futures_unrealized_pnl': {'value': '100', 'currency': 'USD'},
            'perp_unrealized_pnl': {'value': '100', 'currency': 'USD'}
          },
          'spot_positions': [],
          'perp_positions': [],
          'futures_positions': []
        }
      };

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      final breakdown = await getPortfolioBreakdown(
          uuid: 'uuid1', client: mockClient, credential: credential);

      expect(breakdown, isA<PortfolioBreakdown>());
      expect(breakdown?.portfolio.name, 'portfolio1');
    });
  });

  group('Portfolios API tests Requests to Coinbase AT API Endpoints',
      skip: skip, () {
    test('getPortfolioBreakdown returns a portfolio breakdown', () async {
      final portfolioBreakdown = await getPortfolioBreakdown(
          uuid: portfolioBreakdownGetUUID, credential: credential);

      print(portfolioBreakdown);
      expect(portfolioBreakdown, isA<PortfolioBreakdown>());
    });

    test('listPortfolios returns a list of portfolios', () async {
      final portfolios = await listPortfolios(credential: credential);

      for (Portfolio portfolio in portfolios) {
        print('portfolio: $portfolio');
      }

      expect(portfolios, isA<List<Portfolio>>());
      expect(portfolios.isNotEmpty, true);
    });

    test('createPortfolio returns a portfolio', skip: skipDT, () async {
      final Portfolio? createdPortfolio = await createPortfolio(
          name: portfolioCreateName, credential: credential);

      print('portfolio: $createdPortfolio');

      expect(createdPortfolio, isA<Portfolio>());
      expect(createdPortfolio?.name, portfolioCreateName);
    });

    test('editPortfolio returns a portfolio with the changed name',
        skip: skipDT, () async {
      final portfolio = await editPortfolio(
          uuid: portfolioEditUUID,
          name: portfolioEditNewName,
          credential: credential);

      expect(portfolio, isA<Portfolio>());
      expect(portfolio?.name, portfolioEditNewName);
    });

    test('deletePortfolio returns true', skip: skipDT, () async {
      final result = await deletePortfolio(
          uuid: portfolioDeleteUUID, credential: credential);

      expect(result, true);
    });

    test('movePortfolioFunds returns true when transferring One Dollar of USDC',
        () async {
      final result = await movePortfolioFunds(
          funds: {'currency': 'USDC', 'value': '1.0'},
          sourcePortfolioUuid: portfolioMoveFundsSourceUUID,
          targetPortfolioUuid: portfolioMoveFundsTargetUUID,
          credential: credential);

      expect(result, true);
    });
  });
}
