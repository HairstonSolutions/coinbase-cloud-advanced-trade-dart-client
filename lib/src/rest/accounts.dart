import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/coinbase_http_options.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/pagination.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/page.dart';
import 'package:http/http.dart' as http;

/// Gets a single page of accounts for the current user.
///
/// GET /api/v3/brokerage/accounts
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/accounts/list-accounts
///
/// This function makes a GET request to the /accounts endpoint of the Coinbase
/// Advanced Trade API. It supports pagination using a cursor.
///
/// [limit] - A limit on the number of accounts to be returned.
/// [cursor] - A cursor for pagination.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Page] of [Account] objects.
Future<Page<Account>> getAccountsPage(
    {int? limit = 250,
    String? cursor,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Account> accounts = [];
  Map<String, dynamic>? queryParameters = {'limit': '$limit'};
  if (cursor != null) {
    queryParameters['cursor'] = cursor;
  }

  http.Response response = await getAuthorized('/accounts',
      queryParameters: queryParameters,
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonAccounts = jsonResponse['accounts'];
    String? jsonCursor = jsonResponse['cursor'];
    bool hasNext = jsonResponse['has_next'] ?? false;

    for (var jsonObject in jsonAccounts) {
      accounts.add(Account.fromCBJson(jsonObject));
    }

    return Page<Account>(
      items: accounts,
      nextCursor: jsonCursor,
      hasNext: hasNext,
    );
  } else {
    throw CoinbaseException(
        'Failed to get accounts page', response.statusCode, response.body);
  }
}

/// Gets a list of accounts for the current user.
///
/// GET /api/v3/brokerage/accounts
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/accounts/list-accounts
///
/// This function makes a GET request to the /accounts endpoint of the Coinbase
/// Advanced Trade API. It supports pagination using a cursor. Pages are
/// followed while the response reports `has_next` and returns a new cursor,
/// so a final page that still carries a cursor ends the loop.
///
/// [limit] - A limit on the number of accounts to be returned.
/// [cursor] - A cursor for pagination.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Account] objects.
Future<List<Account>> getAccounts(
    {int? limit = 250,
    String? cursor,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Account> accounts = [];
  String? currentCursor = cursor;

  while (true) {
    Page<Account> page = await getAccountsPage(
        limit: limit,
        cursor: currentCursor,
        client: client,
        options: options,
        credential: credential,
        isSandbox: isSandbox);

    accounts.addAll(page.items);

    String? nextCursor = nextPageCursor(page, currentCursor);
    if (nextCursor == null) {
      break;
    }
    currentCursor = nextCursor;
  }

  return accounts;
}

/// Gets a single account for the current user by currency.
///
/// This function makes a GET request to the /accounts endpoint of the Coinbase
/// Advanced Trade API and filters the results by currency.
///
/// [currency] - The currency of the account to be returned.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Account] object, or null if no account is found for the given
/// currency.
Future<Account?> getAccountByCurrency(String currency,
    {http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Account> accounts = await getAccounts(
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);

  int index = accounts.indexWhere((account) => account.currency == currency);
  if (index != -1) {
    return accounts[index];
  }
  return null;
}

/// Gets a single account for the current user by UUID.
///
/// GET /api/v3/brokerage/accounts/{account_uuid}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/accounts/get-account
///
/// This function makes a GET request to the /accounts/{uuid} endpoint of the
/// Coinbase Advanced Trade API.
///
/// [uuid] - The UUID of the account to be returned.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Account] object, or null if no account is found for the given
/// UUID.
Future<Account?> getAccount(
    {required String? uuid,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/accounts/$uuid',
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var jsonAccount = jsonResponse['account'];

    return Account.fromCBJson(jsonAccount);
  } else {
    throw CoinbaseException(
        'Failed to get account', response.statusCode, response.body);
  }
}

/// Gets the balance of a single account for the current user.
///
/// This function can get the balance by either the account UUID or the currency.
///
/// [uuid] - The UUID of the account.
/// [currency] - The currency of the account.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns the available balance of the account as a [Decimal], or null if
/// the account is not found.
Future<Decimal?> getAccountBalance(
    {String? uuid,
    String? currency,
    http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  if (uuid != null) {
    Account? account = await getAccount(
        uuid: uuid,
        client: client,
        options: options,
        credential: credential,
        isSandbox: isSandbox);
    return account?.availableBalance;
  }

  if (currency != null) {
    Account? account = await getAccountByCurrency(currency,
        client: client,
        options: options,
        credential: credential,
        isSandbox: isSandbox);
    return account?.availableBalance;
  }

  return null;
}
