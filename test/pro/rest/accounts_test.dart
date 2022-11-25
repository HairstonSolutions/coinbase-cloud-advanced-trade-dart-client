import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/pro/models/account.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/pro/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/pro/rest/accounts.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? checkEnvSandbox = envVars['COINBASE_SANDBOX'];
String? cbAccessKey = envVars['COINBASE_ACCESS_KEY'];
String? cbSecret = envVars['COINBASE_SECRET'];
String? cbPassphrase = envVars['COINBASE_PASSPHRASE'];
bool isSbx = checkEnvSandbox == 'true' ? true : false;
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials = Credential(cbAccessKey!, cbSecret!, cbPassphrase!);

void main() {
  group('Test Accounts', skip: skip, () {
    test('Get Accounts for an API key', () async {
      List<Account> accounts =
          await getAccounts(credential: credentials, isSandbox: true);

      print('Accounts : $accounts');
      expect(accounts.isEmpty, false);
    });

    test('Get Account by Account ID for an API key', () async {
      Account? originAccount = await getAccountByCurrency('BTC',
          credential: credentials, isSandbox: true);

      String accountId = originAccount!.id!;
      Account? account =
          await getAccount(accountId, credential: credentials, isSandbox: true);

      print('Account : $account');
      expect(account?.currency, 'BTC');
    });

    test('Get Account by Currency name for an API key', () async {
      Account? account = await getAccountByCurrency('BTC',
          credential: credentials, isSandbox: true);

      print('Account : $account');
      expect(account?.currency, 'BTC');
    });

    test('Account NA for given Currency name for an API key', () async {
      Account? account = await getAccountByCurrency('DOGE',
          credential: credentials, isSandbox: true);

      expect(account, null);
    });
  });
}
