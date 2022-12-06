import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

// Recursive for Paginated requests
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
      isSandbox: true);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonAccounts = jsonResponse['accounts'];
    String? jsonCursor = jsonResponse['cursor'];

    for (var jsonObject in jsonAccounts) {
      accounts.add(Account.convertJson(jsonObject));
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

Future<Account?> getAccount(
    {required String? uuid,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/accounts/$uuid',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var jsonAccount = jsonResponse['account'];

    return Account.convertJson(jsonAccount);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

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
