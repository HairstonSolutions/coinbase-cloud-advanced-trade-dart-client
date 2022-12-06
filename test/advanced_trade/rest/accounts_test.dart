import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/accounts.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
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

    test('Get Account by Currency name for an API key', () async {
      Account? account = await getAccountByCurrency('BTC',
          credential: credentials, isSandbox: true);

      print('Account : $account');
      expect(account?.currency, 'BTC');
    });

    test('Get Account by Account ID for an API key', () async {
      Account? originAccount = await getAccountByCurrency('BTC',
          credential: credentials, isSandbox: true);

      String accountId = originAccount!.uuid!;
      Account? account = await getAccount(
          uuid: accountId, credential: credentials, isSandbox: true);

      print('Account : $account');
      expect(account?.currency, 'BTC');
    });

    test('Account NA for given Currency name for an API key', () async {
      Account? account = await getAccountByCurrency('DOGE',
          credential: credentials, isSandbox: true);

      expect(account, null);
    });

    test('Authorized Get Account by Account ID', () async {
      List<Account?> accounts =
          await getAccounts(credential: credentials, isSandbox: true);
      print('Accounts: $accounts');

      String? accountUUID = accounts.first?.uuid;

      Account? account = await getAccount(
          uuid: accountUUID, credential: credentials, isSandbox: true);
      print('Accounts: $account');
      expect(account?.uuid, accountUUID);
    });

    test('Get Account Balance by Account Currency', () async {
      String currency = 'BTC';
      double? balance = await getAccountBalance(
          currency: currency, credential: credentials, isSandbox: true);
      expect(balance != null, true);
    });

    test('Get Account Balance by Account UUID', () async {
      String currency = 'BTC';
      Account? account = await getAccountByCurrency(currency,
          credential: credentials, isSandbox: true);
      String? uuid = account?.uuid;
      double? balance = await getAccountBalance(
          uuid: uuid, credential: credentials, isSandbox: true);
      expect(balance != null, true);
    });

    test(
        'Get Account Balance cancels when neither a uuid or currency is provided',
        () async {
      double? balance =
          await getAccountBalance(credential: credentials, isSandbox: true);
      expect(balance, null);
    });
  });
}
