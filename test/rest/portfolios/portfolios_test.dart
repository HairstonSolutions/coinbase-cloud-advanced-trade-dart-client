import 'package:coinbase_cloud_advanced_trade_client/src/models/portfolio.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/portfolio_breakdown.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/portfolios.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

final String portfolioCreateName =
    constants.envVars['PORTFOLIO_CREATE_NAME'] ?? 'portfolioTDD1';
final String portfolioGetUUID = constants.envVars['PORTFOLIO_GET_UUID'] ??
    '88888888-4444-4444-4444-121212121212';
final String portfolioBreakdownGetUUID =
    constants.envVars['PORTFOLIO_BREAKDOWN_GET_UUID'] ??
        '88888888-4444-4444-4444-121212121212';
final String portfolioDeleteUUID = constants.envVars['PORTFOLIO_DELETE_UUID'] ??
    '88888888-4444-4444-4444-121212121212';
final String portfolioEditUUID = constants.envVars['PORTFOLIO_EDIT_UUID'] ??
    '88888888-4444-4444-4444-121212121212';
final String portfolioEditNewName =
    constants.envVars['PORTFOLIO_EDIT_NEW_NAME'] ?? 'portfolioTDD2';
final String portfolioMoveFundsSourceUUID =
    constants.envVars['PORTFOLIO_MOVE_FUNDS_SOURCE_UUID'] ??
        '88888888-4444-4444-4444-121212121212';
final String portfolioMoveFundsTargetUUID =
    constants.envVars['PORTFOLIO_MOVE_FUNDS_TARGET_UUID'] ??
        '88888888-4444-4444-4444-121212121212';

void main() {
  final Logger logger = setupLogger('portfolios_test');

  final mockClient = MockClient();
  final credential = constants.credentials;

  group('Portfolios API tests using Mocks', () {
    test('listPortfolios returns a list of portfolios', () async {
      final String response =
          await getJsonFromFile('rest/portfolios/list_portfolios.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(response, 200));

      final portfolios =
          await listPortfolios(client: mockClient, credential: credential);

      expect(portfolios, isA<List<Portfolio>>());
      expect(portfolios.length, 2);
    });

    test('createPortfolio returns a portfolio', () async {
      final String response =
          await getJsonFromFile('rest/portfolios/create_portfolio.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(response, 200));

      final portfolio = await createPortfolio(
          name: 'portfolio1', client: mockClient, credential: credential);

      expect(portfolio, isA<Portfolio>());
      expect(portfolio?.name, 'portfolio1');
    });

    test('editPortfolio returns a portfolio', () async {
      final String response =
          await getJsonFromFile('rest/portfolios/edit_portfolio.json');

      when(mockClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(response, 200));

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
      final String response =
          await getJsonFromFile('rest/portfolios/get_portfolio_breakdown.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(response, 200));

      final breakdown = await getPortfolioBreakdown(
          uuid: 'uuid1', client: mockClient, credential: credential);

      expect(breakdown, isA<PortfolioBreakdown>());
      expect(breakdown?.portfolio.name, 'portfolio1');
    });
  });

  group('Portfolios API tests Requests to Coinbase AT API Endpoints',
      skip: constants.skipDT, () {
    test('listPortfolios returns a list of portfolios', () async {
      final portfolios = await listPortfolios(credential: credential);

      for (Portfolio portfolio in portfolios) {
        logger.info('portfolio: $portfolio');
      }

      expect(portfolios, isA<List<Portfolio>>());
      expect(portfolios.isNotEmpty, true);
    });

    test('getPortfolioBreakdown returns a portfolio breakdown', () async {
      final portfolioBreakdown = await getPortfolioBreakdown(
          uuid: portfolioBreakdownGetUUID, credential: credential);

      logger.info(portfolioBreakdown);
      expect(portfolioBreakdown, isA<PortfolioBreakdown>());
    });

    test('createPortfolio returns a portfolio', skip: constants.skipDT,
        () async {
      final Portfolio? createdPortfolio = await createPortfolio(
          name: portfolioCreateName, credential: credential);

      logger.info('portfolio: $createdPortfolio');

      expect(createdPortfolio, isA<Portfolio>());
      expect(createdPortfolio?.name, portfolioCreateName);
    });

    test('editPortfolio returns a portfolio with the changed name',
        skip: constants.skipDT, () async {
      final portfolio = await editPortfolio(
          uuid: portfolioEditUUID,
          name: portfolioEditNewName,
          credential: credential);

      expect(portfolio, isA<Portfolio>());
      expect(portfolio?.name, portfolioEditNewName);
    });

    test('deletePortfolio returns true', skip: constants.skipDT, () async {
      final result = await deletePortfolio(
          uuid: portfolioDeleteUUID, credential: credential);

      expect(result, true);
    });

    test('movePortfolioFunds returns true when transferring One Dollar of USDC',
        skip: constants.skipDT, () async {
      final result = await movePortfolioFunds(
          funds: {'currency': 'USDC', 'value': '1.0'},
          sourcePortfolioUuid: portfolioMoveFundsSourceUUID,
          targetPortfolioUuid: portfolioMoveFundsTargetUUID,
          credential: credential);

      expect(result, true);
    });
  });
}
