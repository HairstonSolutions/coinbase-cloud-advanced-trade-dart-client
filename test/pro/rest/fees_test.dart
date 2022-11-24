import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/pro/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/pro/rest/fees.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/shared/models/fee.dart';
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
  group('Test Fees Endpoint', () {
    setUp(() {});

    test('Get Fees for a User', skip: skip, () async {
      Fee? myFees = await getFees(credential: credentials, isSandbox: true);
      print('Fees: $myFees');

      expect(myFees != null, true);
    });
  });
}
