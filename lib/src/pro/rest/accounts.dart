import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/pro/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/pro/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/pro/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of accounts for the current user.
///
/// This function makes a GET request to the /accounts endpoint of the Coinbase
/// Pro API.
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Account] objects.
Future<List<Account>> getAccounts(
    {required Credential credential, bool isSandbox = false}) async {
  List<Account> accounts = [];

  http.Response response = await getAuthorized('/accounts',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);

    for (var jsonObject in jsonResponse) {
      accounts.add(Account.convertJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return accounts;
}

/// Gets a single account for the current user by account ID.
///
/// This function makes a GET request to the /accounts/{account_id} endpoint of
/// the Coinbase Pro API.
///
/// [accountId] - The ID of the account to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Account] object, or null if no account is found for the given
/// account ID.
Future<Account?> getAccount(String accountId,
    {required Credential credential, bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/accounts/$accountId',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonObject = jsonDecode(response.body);
    return Account.convertJson(jsonObject);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets a single account for the current user by currency.
///
/// This function makes a GET request to the /accounts endpoint of the Coinbase
/// Pro API and filters the results by currency.
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
