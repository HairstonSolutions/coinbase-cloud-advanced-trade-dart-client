import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/entities/accounts.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/account.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
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

      expect(accounts.isEmpty, false);
    });
  });
}
