import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/account.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/rest/accounts.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/advanced_trade/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? cbApiKey = envVars['COINBASE_API_KEY'];
String? cbApiSecret = envVars['COINBASE_API_SECRET'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials = Credential(cbApiKey!, cbApiSecret!);

void main() {
  group('Test Get Accounts Requests to Coinbase AT API Endpoints', skip: skip,
      () {
    setUp(() {});

    test('Authorized Get Accounts', () async {
      String requestPath = '/accounts';
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);

      expect(true, isTrue);
    });

    test('Authorized Get Accounts', () async {
      List<Account?> accounts =
          await getAccounts(credential: credentials, isSandbox: true);
      print('Accounts: $accounts');
      expect(accounts.isNotEmpty, true);
    });

    test('Authorized Get Accounts with limit', () async {
      int limit = 100;
      List<Account?> accounts = await getAccounts(
          limit: limit, credential: credentials, isSandbox: true);
      print('Accounts: $accounts');
      expect(accounts.isNotEmpty, true);
    });

    test('Authorized Get Accounts with pagination cursor', () async {
      int limit = 1; // Forces a cursor value to be returned
      List<Account?> accounts = await getAccounts(
          limit: limit, credential: credentials, isSandbox: true);
      print('Accounts: $accounts');
      expect(accounts.isNotEmpty, true);
    });
  });
}
