import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? apiKeyName = envVars['COINBASE_API_KEY_NAME'];
String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials =
    Credential(apiKeyName: apiKeyName!, privateKeyPEM: privateKeyPEM!);

void main() {
  group('Test Authorized Requests to Coinbase API Endpoints', skip: skip, () {
    setUp(() {});

    test('Authorized Get with no body (Fees)', () async {
      String requestPath = "/transaction_summary";
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: false);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized Get to Accounts', () async {
      String requestPath = "/accounts";
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized Get to Sandbox Accounts', () async {
      String requestPath = "/accounts";
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });
  });
}
