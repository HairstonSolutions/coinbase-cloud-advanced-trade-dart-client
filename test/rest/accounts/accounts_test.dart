import 'dart:convert';
import 'dart:io';
import 'package:coinbase_cloud_advanced_trade_client/src/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/accounts.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('accounts_test');

  group('Test Get Accounts using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of accounts', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_accounts.json');

      when(mockClient.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      List<Account> accounts = await getAccounts(
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(accounts.length, 2);
      expect(accounts[0].uuid, "8bfc20d7-f7c6-4422-9181-51268ba51372");
      expect(accounts[0].currency, "BTC");
      expect(accounts[1].currency, "USD");
    });

    test('Get a single account by UUID', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_account.json');

      when(mockClient.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      Account? account = await getAccount(
          uuid: "8bfc20d7-f7c6-4422-9181-51268ba51372",
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(account, isNotNull);
      expect(account?.uuid, "8bfc20d7-f7c6-4422-9181-51268ba51372");
      expect(account?.currency, "BTC");
      expect(account?.availableBalance, 100.00);
    });

    test('Get a single account by currency', () async {
      final String mockResponse = await getJsonFromFile(
          'rest/accounts/get_accounts.json'); // Reusing get_accounts.json as it contains the needed account

      when(mockClient.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      Account? account = await getAccountByCurrency("BTC",
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(account, isNotNull);
      expect(account?.currency, 'BTC');
    });

    test('Get account balance by currency', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_accounts.json');

      when(mockClient.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      double? balance = await getAccountBalance(
          currency: 'BTC',
          client: mockClient,
          credential: constants.credentials);

      expect(balance, isNotNull);
      expect(balance, 100.00);
    });

    test('Get account balance by UUID', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_account.json');

      when(mockClient.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      double? balance = await getAccountBalance(
          uuid: '8bfc20d7-f7c6-4422-9181-51268ba51372',
          client: mockClient,
          credential: constants.credentials);

      expect(balance, isNotNull);
      expect(balance, 100.00);
    });

    test('Return null balance when no uuid or currency is provided', () async {
      double? balance = await getAccountBalance(
          client: mockClient, credential: constants.credentials);
      expect(balance, isNull);
    });

    test('Return null when account not found by currency', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_accounts_empty.json');

      when(mockClient.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(mockResponse)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      Account? account = await getAccountByCurrency('DOGE',
          client: mockClient, credential: constants.credentials);
      expect(account, isNull);
    });
  });
  group('Test Get Accounts Requests to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    setUp(() {});

    test('Authorized Get Accounts', () async {
      String requestPath = '/accounts';
      var response = await getAuthorized(requestPath,
          credential: constants.credentials, isSandbox: false);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);

      expect(true, isTrue);
    });

    test('Authorized Get Accounts', () async {
      List<Account?> accounts = await getAccounts(
          credential: constants.credentials, isSandbox: false);
      logger.info('Accounts: $accounts');
      expect(accounts.isNotEmpty, true);
    });

    test('Authorized Get Accounts with limit', () async {
      int limit = 100;
      List<Account?> accounts = await getAccounts(
          limit: limit, credential: constants.credentials, isSandbox: false);
      logger.info('Accounts: $accounts');
      expect(accounts.isNotEmpty, true);
    });

    test('Authorized Get Accounts with pagination cursor', () async {
      int limit = 1; // Forces a cursor value to be returned
      List<Account?> accounts = await getAccounts(
          limit: limit, credential: constants.credentials, isSandbox: false);
      logger.info('Accounts: $accounts');
      expect(accounts.isNotEmpty, true);
    });

    test('Get Account by Currency name for an API key', () async {
      Account? account = await getAccountByCurrency('BTC',
          credential: constants.credentials, isSandbox: false);

      logger.info('Account : $account');
      expect(account?.currency, 'BTC');
    });

    test('Get Account by Account ID for an API key', () async {
      Account? originAccount = await getAccountByCurrency('BTC',
          credential: constants.credentials, isSandbox: false);

      String accountId = originAccount!.uuid!;
      Account? account = await getAccount(
          uuid: accountId, credential: constants.credentials, isSandbox: false);

      logger.info('Account : $account');
      expect(account?.currency, 'BTC');
    });

    test('Account NA for given Currency name for an API key', () async {
      Account? account = await getAccountByCurrency('DOGES',
          credential: constants.credentials, isSandbox: false);

      expect(account, null);
    });

    test('Authorized Get Account by Account ID', () async {
      List<Account?> accounts = await getAccounts(
          credential: constants.credentials, isSandbox: false);
      logger.info('Accounts: $accounts');

      String? accountUUID = accounts.first?.uuid;

      Account? account = await getAccount(
          uuid: accountUUID,
          credential: constants.credentials,
          isSandbox: false);
      logger.info('Accounts: $account');
      expect(account?.uuid, accountUUID);
    });

    test('Get Account Balance by Account Currency', () async {
      String currency = 'BTC';
      double? balance = await getAccountBalance(
          currency: currency,
          credential: constants.credentials,
          isSandbox: false);
      expect(balance != null, true);
    });

    test('Get Account Balance by Account UUID', () async {
      String currency = 'BTC';
      Account? account = await getAccountByCurrency(currency,
          credential: constants.credentials, isSandbox: false);
      String? uuid = account?.uuid;
      double? balance = await getAccountBalance(
          uuid: uuid, credential: constants.credentials, isSandbox: false);
      expect(balance != null, true);
    });

    test(
        'Get Account Balance cancels when neither a uuid or currency is provided',
        () async {
      double? balance = await getAccountBalance(
          credential: constants.credentials, isSandbox: false);
      expect(balance, null);
    });
  });
}
