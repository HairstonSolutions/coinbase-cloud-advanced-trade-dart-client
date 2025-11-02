import 'dart:convert';

import 'package:coinbase_pro_sdk/src/models/credential.dart';
import 'package:coinbase_pro_sdk/src/models/fee.dart';
import 'package:coinbase_pro_sdk/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets the current fee rates for the user.
///
/// This function makes a GET request to the /fees endpoint of the Coinbase Pro
/// API.
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Fee] object, or null if the request fails.
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
