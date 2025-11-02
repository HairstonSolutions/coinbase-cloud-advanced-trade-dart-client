import 'dart:io' show Platform;

import 'package:coinbase_pro_sdk/src/models/ticker.dart';
import 'package:coinbase_pro_sdk/src/rest/products/ticker.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? checkEnvSandbox = envVars['COINBASE_SANDBOX'];
bool isSbx = checkEnvSandbox == 'true' ? true : false;

void main() {
  group('Test Ticker Endpoint', () {
    setUp(() => null);

    test('Get Ticker', () async {
      Ticker? ticker = await getTicker('BTC-USD');
      print(ticker);

      expect(ticker != null, true);
    });

    test('Get Ticker from sandbox', () async {
      Ticker? ticker = await getTicker('BTC-USD', isSandbox: true);
      print(ticker);

      expect(ticker != null, true);
    });
  });
}
