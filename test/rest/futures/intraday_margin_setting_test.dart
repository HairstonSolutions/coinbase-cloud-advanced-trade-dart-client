import 'dart:convert';
import 'package:coinbase_cloud_advanced_trade_client/coinbase_cloud_advanced_trade_client.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:test/test.dart';

import '../../tools.dart';

void main() {
  group('Futures REST API - Intraday Margin Setting', () {
    late Credential credential;

    setUp(() {
      credential = Credential(
        apiKeyName: 'test_key',
        privateKeyPEM: '-----BEGIN EC PRIVATE KEY-----\n'
            'MHcCAQEEIObDWeGqR9p3N+y9XoZl1K+wK/Xy5GvB6C8u3r/aJqgYoAoGCCqGSM49\n'
            'AwEHoUQDQgAE+hEw/x8xK+A/wF2lO8Y3/0J6z/z6R5tH3i2yX2sJ+GvQY5O8L1iV\n'
            'r5s7fM8o9+w7s0s9m2y+M9p4k9o5/s+J+Q==\n'
            '-----END EC PRIVATE KEY-----',
      );
    });

    test('Deserialize IntradayMarginSettingResponse from JSON', () async {
      var jsonStr = await getJsonFromFile(
          'rest/futures/mocks/intraday_margin_setting.json');
      var jsonMap = jsonDecode(jsonStr);
      var response = IntradayMarginSettingResponse.fromCBJson(jsonMap);

      expect(response.setting, IntradayMarginSetting.unspecified);
    });

    test('Test actual Coinbase API endpoint (GET /cfm/intraday/margin_setting)',
        () async {
      try {
        var response = await getIntradayMarginSetting(
            credential: credential, isSandbox: true);
        expect(response, isNotNull);
        expect(response?.setting, isA<IntradayMarginSetting>());
      } catch (e) {
        if (e is CoinbaseException && e.statusCode == 401) {
          markTestSkipped(
              'Skipping due to invalid credentials (401 Unauthorized).');
        } else {
          rethrow;
        }
      }
    }, skip: 'Requires valid credentials');
  });
}
