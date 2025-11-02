import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/account.dart';
import 'package:test/test.dart';

import '../tools.dart';

void main() {
  group('Account Object Injection', () {
    String exampleAccountJsonFile = 'models/examples/account.json';
    String? exampleAccountJson;

    setUp(() async {
      exampleAccountJson = await getJsonFromFile(exampleAccountJsonFile);
    });

    test('Account JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleAccountJson!);
      Account? exampleAccount = Account.fromCBJson(jsonAsMap);

      print('Account Object: $exampleAccount');

      expect(exampleAccount.uuid, '8bfc20d7-f7c6-4422-bf07-8243ca4169fe');
      expect(exampleAccount.name, 'BTC Wallet');
      expect(exampleAccount.currency, 'BTC');
      expect(exampleAccount.availableBalance, 1.23);
      expect(exampleAccount.isDefault, false);
      expect(exampleAccount.active, true);
      expect(exampleAccount.createdAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.updatedAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.deletedAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.type, 'ACCOUNT_TYPE_UNSPECIFIED');
      expect(exampleAccount.ready, true);
      expect(exampleAccount.holdValue, 1.23);
    });

    test('Account JSON Import, Serialize, deserialize', () {
      var jsonAsMap = jsonDecode(exampleAccountJson!);
      Account? exampleAccount = Account.fromCBJson(jsonAsMap);
      var serializedAccount = exampleAccount.toJson();

      Account? deserializedAccount = Account.fromJson(serializedAccount);

      print('Deserialized Account Object: $deserializedAccount');
      print(jsonEncode(deserializedAccount));

      expect(exampleAccount.uuid, '8bfc20d7-f7c6-4422-bf07-8243ca4169fe');
      expect(exampleAccount.name, 'BTC Wallet');
      expect(exampleAccount.currency, 'BTC');
      expect(exampleAccount.availableBalance, 1.23);
      expect(exampleAccount.isDefault, false);
      expect(exampleAccount.active, true);
      expect(exampleAccount.createdAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.updatedAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.deletedAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.type, 'ACCOUNT_TYPE_UNSPECIFIED');
      expect(exampleAccount.ready, true);
      expect(exampleAccount.holdValue, 1.23);
    });
  });
}
