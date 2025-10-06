import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of accounts for the current user.
///
/// This function makes a GET request to the /accounts endpoint of the Coinbase
/// Advanced Trade API. It supports pagination using a cursor.
///
/// [limit] - A limit on the number of accounts to be returned.
/// [cursor] - A cursor for pagination.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Account] objects.
Future<List<Account>> getAccounts(
    {int? limit = 250,
    String? cursor,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Account> accounts = [];
  Map<String, dynamic>? queryParameters = {'limit': '$limit'};
  (cursor != null) ? queryParameters.addAll({'cursor': cursor}) : null;

  http.Response response = await getAuthorized('/accounts',
      queryParameters: queryParameters,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonAccounts = jsonResponse['accounts'];
    String? jsonCursor = jsonResponse['cursor'];

    for (var jsonObject in jsonAccounts) {
      accounts.add(Account.fromCBJson(jsonObject));
    }
    // Recursive Break
    if (jsonCursor != null && jsonCursor != '') {
      // Recursive Call
      List<Account> paginatedAccounts = await getAccounts(
          limit: limit,
          cursor: jsonCursor,
          credential: credential,
          isSandbox: isSandbox);
      accounts.addAll(paginatedAccounts);
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
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
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Account] object, or null if no account is found for the given
/// currency.
Future<Account?> getAccountByCurrency(String currency,
    {required Credential credential, bool isSandbox = false}) async {
  List<Account> accounts =
      await getAccounts(credential: credential, isSandbox: isSandbox);

  if (accounts.isNotEmpty) {
    for (Account account in accounts) {
      if (account.currency == currency) {
        return account;
      }
    }
  }
  return null;
}

/// Gets a single account for the current user by UUID.
///
/// This function makes a GET request to the /accounts/{uuid} endpoint of the
/// Coinbase Advanced Trade API.
///
/// [uuid] - The UUID of the account to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Account] object, or null if no account is found for the given
/// UUID.
Future<Account?> getAccount(
    {required String? uuid,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/accounts/$uuid',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var jsonAccount = jsonResponse['account'];

    return Account.fromCBJson(jsonAccount);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets the balance of a single account for the current user.
///
/// This function can get the balance by either the account UUID or the currency.
///
/// [uuid] - The UUID of the account.
/// [currency] - The currency of the account.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns the available balance of the account as a double, or null if the
/// account is not found.
Future<double?> getAccountBalance(
    {String? uuid,
    String? currency,
    required Credential credential,
    bool isSandbox = false}) async {
  if (uuid != null) {
    Account? account = await getAccount(
        uuid: uuid, credential: credential, isSandbox: isSandbox);
    return account?.availableBalance;
  }

  if (currency != null) {
    Account? account = await getAccountByCurrency(currency,
        credential: credential, isSandbox: isSandbox);
    return account?.availableBalance;
  }

  return null;
}
