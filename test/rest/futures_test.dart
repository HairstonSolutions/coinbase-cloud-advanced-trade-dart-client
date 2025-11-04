import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/futures.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_constants.dart';
import '../tools.dart';
import 'futures_test.mocks.dart';

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);

@GenerateMocks([http.Client])
void main() {
  group('Futures REST Tests', () {
    test('Get Futures Balance Summary', () async {
      final client = MockClient();
      final String getFuturesBalanceSummaryJson = await getJsonFromFile(
          'test/rest/futures/get_futures_balance_summary.json');

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(getFuturesBalanceSummaryJson, 200));

      final result = await getFuturesBalanceSummary(
          client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result!.totalUsdBalance, isNotNull);
    });

    test('List Futures Positions', () async {
      final client = MockClient();
      final String listFuturesPositionsJson =
          await getJsonFromFile('test/rest/futures/list_futures_positions.json');

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(listFuturesPositionsJson, 200));

      final result =
          await listFuturesPositions(client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result!.positions, isNotNull);
    });

    test('Get Futures Position', () async {
      final client = MockClient();
      final String getFuturesPositionJson =
          await getJsonFromFile('test/rest/futures/get_futures_position.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(getFuturesPositionJson, 200));

      final result = await getFuturesPosition(
          client: client, credential: credentials, productId: 'BTC-USD');

      expect(result, isNotNull);
      expect(result!.productId, isNotNull);
    });

    test('List Futures Sweeps', () async {
      final client = MockClient();
      final String listFuturesSweepsJson =
          await getJsonFromFile('test/rest/futures/list_futures_sweeps.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(listFuturesSweepsJson, 200));

      final result =
          await listFuturesSweeps(client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result!.sweeps, isNotNull);
    });

    test('Schedule Futures Sweep', () async {
      final client = MockClient();
      final String scheduleFuturesSweepJson = await getJsonFromFile(
          'test/rest/futures/schedule_futures_sweep.json');

      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(scheduleFuturesSweepJson, 200));

      final result = await scheduleFuturesSweep(
          client: client, credential: credentials, usdAmount: '100');

      expect(result, isNotNull);
      expect(result!.success, isTrue);
    });

    test('Cancel Pending Futures Sweep', () async {
      final client = MockClient();
      final String cancelPendingFuturesSweepJson = await getJsonFromFile(
          'test/rest/futures/cancel_pending_futures_sweep.json');

      when(client.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(cancelPendingFuturesSweepJson, 200));

      final result = await cancelPendingFuturesSweep(
          client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result!.success, isTrue);
    });

    test('Get Intraday Margin Setting', () async {
      final client = MockClient();
      final String getIntradayMarginSettingJson = await getJsonFromFile(
          'test/rest/futures/get_intraday_margin_setting.json');

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(getIntradayMarginSettingJson, 200));

      final result = await getIntradayMarginSetting(
          client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result!.setting, isNotNull);
    });

    test('Set Intraday Margin Setting', () async {
      final client = MockClient();
      final String setIntradayMarginSettingJson = await getJsonFromFile(
          'test/rest/futures/set_intraday_margin_setting.json');

      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(setIntradayMarginSettingJson, 200));

      final result = await setIntradayMarginSetting(
          client: client, credential: credentials, enabled: true);

      expect(result, isNotNull);
      expect(result!.setting, isNotNull);
    });

    test('Close Position', () async {
      final client = MockClient();
      final String closePositionJson =
          await getJsonFromFile('test/rest/futures/close_position.json');

      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(closePositionJson, 200));

      final result = await closeFuturesPosition(
          client: client,
          credential: credentials,
          clientOrderId: '1234',
          productId: 'BTC-USD',
          size: '1');

      expect(result, isNotNull);
      expect(result!.success, isTrue);
    });
  });
}
