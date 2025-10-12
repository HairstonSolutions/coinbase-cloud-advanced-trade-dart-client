import 'dart:convert';
import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/accounts.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';

Map<String, String> envVars = Platform.environment;
String apiKeyName = envVars['COINBASE_API_KEY_NAME'] ?? 'api_key_name';
String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;

void main() {
  group('Test Get Accounts using MockClient', () {
    late MockClient mockClient;
    final Credential credentials =
        Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM!);

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of accounts', () async {
      final mockResponse = {
        "accounts": [
          {
            "uuid": "8bfc20d7-f7c6-4422-9181-51268ba51372",
            "name": "BTC Wallet",
            "currency": "BTC",
            "type": "ACCOUNT_TYPE_CRYPTO",
            "active": true,
            "created_at": "2021-05-31T09:59:59Z",
            "updated_at": "2021-05-31T09:59:59Z",
            "deleted_at": null,
            "hold": {"value": "0.00000000", "currency": "BTC"},
            "available_balance": {"value": "100.00", "currency": "BTC"},
            "default": false
          },
          {
            "uuid": "00f35d2d-0a95-4834-a81c-8245355a293c",
            "name": "USD Wallet",
            "currency": "USD",
            "type": "ACCOUNT_TYPE_FIAT",
            "active": true,
            "created_at": "2021-05-31T09:59:59Z",
            "updated_at": "2021-05-31T09:59:59Z",
            "deleted_at": null,
            "hold": {"value": "0.00", "currency": "USD"},
            "available_balance": {"value": "1000.00", "currency": "USD"},
            "default": true
          }
        ],
        "has_next": false,
        "cursor": "",
        "size": 2
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      List<Account> accounts = await getAccounts(
          client: mockClient, credential: credentials, isSandbox: false);

      expect(accounts.length, 2);
      expect(accounts[0].uuid, "8bfc20d7-f7c6-4422-9181-51268ba51372");
      expect(accounts[0].currency, "BTC");
      expect(accounts[1].currency, "USD");
    });

    test('Get a single account by UUID', () async {
      final mockResponse = {
        "account": {
          "uuid": "8bfc20d7-f7c6-4422-9181-51268ba51372",
          "name": "BTC Wallet",
          "currency": "BTC",
          "type": "ACCOUNT_TYPE_CRYPTO",
          "active": true,
          "created_at": "2021-05-31T09:59:59Z",
          "updated_at": "2021-05-31T09:59:59Z",
          "deleted_at": null,
          "hold": {"value": "0.00000000", "currency": "BTC"},
          "available_balance": {"value": "100.00", "currency": "BTC"},
          "default": false
        }
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      Account? account = await getAccount(
          uuid: "8bfc20d7-f7c6-4422-9181-51268ba51372",
          client: mockClient,
          credential: credentials,
          isSandbox: false);

      expect(account, isNotNull);
      expect(account?.uuid, "8bfc20d7-f7c6-4422-9181-51268ba51372");
      expect(account?.currency, "BTC");
      expect(account?.availableBalance, 100.00);
    });

    test('Get a single account by currency', () async {
      final mockResponse = {
        "accounts": [
          {
            "uuid": "8bfc20d7-f7c6-4422-9181-51268ba51372",
            "name": "BTC Wallet",
            "currency": "BTC",
            "type": "ACCOUNT_TYPE_CRYPTO",
            "active": true,
            "created_at": "2021-05-31T09:59:59Z",
            "updated_at": "2021-05-31T09:59:59Z",
            "deleted_at": null,
            "hold": {"value": "0.00000000", "currency": "BTC"},
            "available_balance": {"value": "100.00", "currency": "BTC"},
            "default": false
          }
        ],
        "has_next": false,
        "cursor": "",
        "size": 1
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      Account? account = await getAccountByCurrency("BTC",
          client: mockClient, credential: credentials, isSandbox: false);

      expect(account, isNotNull);
      expect(account?.currency, 'BTC');
    });

    test('Get account balance by currency', () async {
      final mockResponse = {
        "accounts": [
          {
            "uuid": "8bfc20d7-f7c6-4422-9181-51268ba51372",
            "name": "BTC Wallet",
            "currency": "BTC",
            "type": "ACCOUNT_TYPE_CRYPTO",
            "active": true,
            "created_at": "2021-05-31T09:59:59Z",
            "updated_at": "2021-05-31T09:59:59Z",
            "deleted_at": null,
            "hold": {"value": "0.00000000", "currency": "BTC"},
            "available_balance": {"value": "100.00", "currency": "BTC"},
            "default": false
          }
        ],
        "has_next": false,
        "cursor": "",
        "size": 1
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      double? balance = await getAccountBalance(
          currency: 'BTC', client: mockClient, credential: credentials);

      expect(balance, isNotNull);
      expect(balance, 100.00);
    });

    test('Get account balance by UUID', () async {
      final mockResponse = {
        "account": {
          "uuid": "8bfc20d7-f7c6-4422-9181-51268ba51372",
          "name": "BTC Wallet",
          "currency": "BTC",
          "type": "ACCOUNT_TYPE_CRYPTO",
          "active": true,
          "created_at": "2021-05-31T09:59:59Z",
          "updated_at": "2021-05-31T09:59:59Z",
          "deleted_at": null,
          "hold": {"value": "0.00000000", "currency": "BTC"},
          "available_balance": {"value": "100.00", "currency": "BTC"},
          "default": false
        }
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      double? balance = await getAccountBalance(
          uuid: '8bfc20d7-f7c6-4422-9181-51268ba51372',
          client: mockClient,
          credential: credentials);

      expect(balance, isNotNull);
      expect(balance, 100.00);
    });

    test('Return null balance when no uuid or currency is provided', () async {
      double? balance =
          await getAccountBalance(client: mockClient, credential: credentials);
      expect(balance, isNull);
    });

    test('Return null when account not found by currency', () async {
      final mockResponse = {
        "accounts": [],
        "has_next": false,
        "cursor": "",
        "size": 0
      };

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      Account? account = await getAccountByCurrency('DOGE',
          client: mockClient, credential: credentials);
      expect(account, isNull);
    });
  });
}
