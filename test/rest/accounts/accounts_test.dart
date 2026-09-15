import 'package:coinbase_cloud_advanced_trade_client/src/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/accounts.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

void main() {
  final Logger logger = setupLogger('accounts_test');

  group('Test Get Accounts using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of accounts (recursive / full)', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_accounts.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      List<Account> accounts = await getAccounts(
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(accounts.length, 2);
      expect(accounts[0].uuid, "8bfc20d7-f7c6-4422-9181-51268ba51372");
      expect(accounts[0].currency, "BTC");
      expect(accounts[1].currency, "USD");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
    });

    test('Get a single page of accounts', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_accounts.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      var page = await getAccountsPage(
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(page.items.length, 2);
      expect(page.hasNext, false);
      expect(page.nextCursor, "");
      expect(page.items[0].uuid, "8bfc20d7-f7c6-4422-9181-51268ba51372");
      expect(page.items[0].currency, "BTC");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
    });

    test('Get accounts follows the cursor while has_next is true', () async {
      final String mockResponsePage1 =
          await getJsonFromFile('rest/accounts/get_accounts_page_1.json');
      final String mockResponsePage2 = await getJsonFromFile(
          'rest/accounts/get_accounts_page_2_stale_cursor.json');

      var callCount = 0;
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        callCount++;
        return http.Response(
            callCount == 1 ? mockResponsePage1 : mockResponsePage2, 200);
      });

      List<Account> accounts = await getAccounts(
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      // Page 2 sets has_next to false while still carrying a cursor, so the
      // loop stops there instead of re-requesting with the stale cursor.
      expect(accounts.length, 2);
      expect(accounts[0].currency, "BTC");
      expect(accounts[1].currency, "USD");
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(2);
    });

    test('Get accounts stops when a page repeats the cursor it was given',
        () async {
      final String mockResponsePage1 =
          await getJsonFromFile('rest/accounts/get_accounts_page_1.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponsePage1, 200));

      List<Account> accounts = await getAccounts(
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(accounts.length, 2);
      verify(mockClient.get(any, headers: anyNamed('headers'))).called(2);
    });

    test('Get a single account by UUID', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_account.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      Account? account = await getAccount(
          uuid: "8bfc20d7-f7c6-4422-9181-51268ba51372",
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(account, isNotNull);
      expect(account?.uuid, "8bfc20d7-f7c6-4422-9181-51268ba51372");
      expect(account?.currency, "BTC");
      expect(account?.availableBalance, Decimal.parse('100.00'));
    });

    test('Get a single account by currency', () async {
      final String mockResponse = await getJsonFromFile(
          'rest/accounts/get_accounts.json'); // Reusing get_accounts.json as it contains the needed account

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

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

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      Decimal? balance = await getAccountBalance(
          currency: 'BTC',
          client: mockClient,
          credential: constants.credentials);

      expect(balance, isNotNull);
      expect(balance, Decimal.parse('100.00'));
    });

    test('Get account balance by UUID', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_account.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      Decimal? balance = await getAccountBalance(
          uuid: '8bfc20d7-f7c6-4422-9181-51268ba51372',
          client: mockClient,
          credential: constants.credentials);

      expect(balance, isNotNull);
      expect(balance, Decimal.parse('100.00'));
    });

    test('Return null balance when no uuid or currency is provided', () async {
      Decimal? balance = await getAccountBalance(
          client: mockClient, credential: constants.credentials);
      expect(balance, isNull);
    });

    test('Return null when account not found by currency', () async {
      final String mockResponse =
          await getJsonFromFile('rest/accounts/get_accounts_empty.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

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
      Decimal? balance = await getAccountBalance(
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
      Decimal? balance = await getAccountBalance(
          uuid: uuid, credential: constants.credentials, isSandbox: false);
      expect(balance != null, true);
    });

    test(
        'Get Account Balance cancels when neither a uuid or currency is provided',
        () async {
      Decimal? balance = await getAccountBalance(
          credential: constants.credentials, isSandbox: false);
      expect(balance, null);
    });
  });
}
