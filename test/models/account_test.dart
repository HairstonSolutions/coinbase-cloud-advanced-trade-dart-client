import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/account.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';
import 'package:logging/logging.dart';
import '../test_helpers.dart';

import '../tools.dart';

void main() {
  final Logger logger = setupLogger('account_test');

  group('Account Object Injection', () {
    String exampleAccountJsonFile = 'models/examples/account.json';
    String? exampleAccountJson;

    setUp(() async {
      exampleAccountJson = await getJsonFromFile(exampleAccountJsonFile);
    });

    test('Account JSON Import Object conversion', () {
      var jsonAsMap = jsonDecode(exampleAccountJson!);
      Account? exampleAccount = Account.fromCBJson(jsonAsMap);

      logger.info('Account Object: $exampleAccount');

      expect(exampleAccount.uuid, '8bfc20d7-f7c6-4422-bf07-8243ca4169fe');
      expect(exampleAccount.name, 'BTC Wallet');
      expect(exampleAccount.currency, 'BTC');
      expect(exampleAccount.availableBalance, Decimal.parse('1.23'));
      expect(exampleAccount.isDefault, false);
      expect(exampleAccount.active, true);
      expect(exampleAccount.createdAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.updatedAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.deletedAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.type, 'ACCOUNT_TYPE_UNSPECIFIED');
      expect(exampleAccount.ready, true);
      expect(exampleAccount.holdValue, Decimal.parse('1.23'));
    });

    test('Account JSON Import, Serialize, deserialize', () {
      var jsonAsMap = jsonDecode(exampleAccountJson!);
      Account? exampleAccount = Account.fromCBJson(jsonAsMap);
      var serializedAccount = exampleAccount.toJson();

      Account? deserializedAccount = Account.fromJson(serializedAccount);

      logger.info('Deserialized Account Object: $deserializedAccount');
      logger.info(jsonEncode(deserializedAccount));

      expect(exampleAccount.uuid, '8bfc20d7-f7c6-4422-bf07-8243ca4169fe');
      expect(exampleAccount.name, 'BTC Wallet');
      expect(exampleAccount.currency, 'BTC');
      expect(exampleAccount.availableBalance, Decimal.parse('1.23'));
      expect(exampleAccount.isDefault, false);
      expect(exampleAccount.active, true);
      expect(exampleAccount.createdAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.updatedAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.deletedAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(exampleAccount.type, 'ACCOUNT_TYPE_UNSPECIFIED');
      expect(exampleAccount.ready, true);
      expect(exampleAccount.holdValue, Decimal.parse('1.23'));
    });

    test('Account round-trips when the optional timestamps are null', () {
      // A live account that has never been deleted carries no deletedAt, so
      // toJson emits null for it. fromJson must accept that.
      final account = Account(
          '8bfc20d7-f7c6-4422-bf07-8243ca4169fe',
          'BTC Wallet',
          'BTC',
          Decimal.parse('1.23'),
          false,
          true,
          null,
          null,
          null,
          'ACCOUNT_TYPE_CRYPTO',
          true,
          Decimal.zero);

      final roundTripped = Account.fromJson(account.toJson());

      expect(roundTripped.uuid, '8bfc20d7-f7c6-4422-bf07-8243ca4169fe');
      expect(roundTripped.availableBalance, Decimal.parse('1.23'));
      expect(roundTripped.createdAt, isNull);
      expect(roundTripped.updatedAt, isNull);
      expect(roundTripped.deletedAt, isNull);
    });

    test('Account from Coinbase JSON round-trips without a deleted_at', () {
      final account = Account.fromCBJson({
        'uuid': '8bfc20d7-f7c6-4422-bf07-8243ca4169fe',
        'name': 'BTC Wallet',
        'currency': 'BTC',
        'available_balance': {'value': '1.23', 'currency': 'BTC'},
        'default': false,
        'active': true,
        'created_at': '2021-05-31T09:59:59Z',
        'updated_at': '2021-05-31T09:59:59Z',
        'type': 'ACCOUNT_TYPE_CRYPTO',
        'ready': true,
        'hold': {'value': '0', 'currency': 'BTC'},
      });

      expect(account.deletedAt, isNull);

      final roundTripped = Account.fromJson(account.toJson());

      expect(roundTripped.deletedAt, isNull);
      expect(roundTripped.createdAt, DateTime.parse('2021-05-31T09:59:59Z'));
      expect(roundTripped.availableBalance, Decimal.parse('1.23'));
    });
  });
}
