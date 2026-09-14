import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/coinbase_http_options.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/key_permissions.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets the key permissions.
///
/// GET /api/v3/brokerage/key_permissions
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/data-api/get-api-key-permissions
///
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [KeyPermissions] object.
Future<KeyPermissions?> getKeyPermissions(
    {http.Client? client,
    CoinbaseHttpOptions? options,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/key_permissions',
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return KeyPermissions.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
        'Failed to get key permissions', response.statusCode, response.body);
  }
}
