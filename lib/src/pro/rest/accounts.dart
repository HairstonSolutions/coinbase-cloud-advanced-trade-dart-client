import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/pro/models/account.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/pro/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/pro/services/network.dart';
import 'package:http/http.dart' as http;

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
