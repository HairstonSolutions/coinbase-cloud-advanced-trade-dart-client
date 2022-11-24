import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? cbApiKey = envVars['COINBASE_API_KEY'];
String? cbApiSecret = envVars['COINBASE_API_SECRET'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials = Credential(cbApiKey!, cbApiSecret!);

void main() {
  group('Test Authorized Requests to Coinbase API Endpoints', skip: skip, () {
    setUp(() {});

    test('Authorized Get with no body (Fees)', () async {
      String requestPath = "/transaction_summary";
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });
  });
}
