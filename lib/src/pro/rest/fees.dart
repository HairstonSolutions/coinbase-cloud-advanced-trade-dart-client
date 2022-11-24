import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/pro/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/pro/services/network.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/shared/models/fee.dart';
import 'package:http/http.dart' as http;

Future<Fee?> getFees(
    {required Credential credential, bool isSandbox = false}) async {
  Fee? fees;

  http.Response response = await getAuthorized('/Fees',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    fees = Fee.convertJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
  }

  return fees;
}
