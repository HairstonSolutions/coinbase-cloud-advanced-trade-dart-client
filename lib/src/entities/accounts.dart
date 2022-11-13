import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/models/account.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
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
