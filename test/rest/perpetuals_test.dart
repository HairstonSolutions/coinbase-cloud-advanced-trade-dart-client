import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/perpetuals.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_constants.dart';
import '../tools.dart';
import 'perpetuals_test.mocks.dart';

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);

@GenerateMocks([http.Client])
void main() {
  group('Perpetuals REST Tests', () {
    test('Get Perpetuals Portfolio Summary', () async {
      final client = MockClient();
      final String getPerpetualsPortfolioSummaryJson = await getJsonFromFile(
          'test/rest/perpetuals/get_perpetuals_portfolio_summary.json');

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(getPerpetualsPortfolioSummaryJson, 200));

      final result = await getPerpetualsPortfolioSummary(
          client: client,
          credential: credentials,
          portfolioUuid: '1234');

      expect(result, isNotNull);
      expect(result!.totalAccountValue, isNotNull);
    });

    test('List Perpetuals Positions', () async {
      final client = MockClient();
      final String listPerpetualsPositionsJson = await getJsonFromFile(
          'test/rest/perpetuals/list_perpetuals_positions.json');

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(listPerpetualsPositionsJson, 200));

      final result = await listPerpetualsPositions(
          client: client,
          credential: credentials,
          portfolioUuid: '1234');

      expect(result, isNotNull);
      expect(result!.positions, isNotNull);
    });

    test('Get Perpetuals Position', () async {
      final client = MockClient();
      final String getPerpetualsPositionJson = await getJsonFromFile(
          'test/rest/perpetuals/get_perpetuals_position.json');

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(getPerpetualsPositionJson, 200));

      final result = await getPerpetualsPosition(
          client: client,
          credential: credentials,
          portfolioUuid: '1234',
          symbol: 'BTC-PERP');

      expect(result, isNotNull);
      expect(result!.productId, isNotNull);
    });

    test('Get Portfolio Balances', () async {
      final client = MockClient();
      final String getPortfolioBalancesJson =
          await getJsonFromFile('test/rest/perpetuals/get_portfolio_balances.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(getPortfolioBalancesJson, 200));

      final result = await getPortfolioBalances(
          client: client,
          credential: credentials,
          portfolioUuid: '1234');

      expect(result, isNotNull);
      expect(result!.portfolioBalances, isNotNull);
    });

    test('Set Multi Asset Collateral', () async {
      final client = MockClient();
      final String setMultiAssetCollateralJson = await getJsonFromFile(
          'test/rest/perpetuals/set_multi_asset_collateral.json');

      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(setMultiAssetCollateralJson, 200));

      final result = await setMultiAssetCollateral(
          client: client,
          credential: credentials,
          portfolioUuid: '1234',
          enabled: true);

      expect(result, isTrue);
    });
  });
}
