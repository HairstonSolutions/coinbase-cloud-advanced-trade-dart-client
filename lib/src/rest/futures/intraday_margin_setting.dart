import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/futures/intraday_margin_setting.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets the intraday margin setting.
///
/// GET /api/v3/brokerage/cfm/intraday/margin_setting
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-intraday-margin-setting
///
/// This function makes a GET request to the /cfm/intraday/margin_setting endpoint of the Coinbase
/// Advanced Trade API.
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [IntradayMarginSettingResponse] object.
Future<IntradayMarginSettingResponse?> getIntradayMarginSetting(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/cfm/intraday/margin_setting',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return IntradayMarginSettingResponse.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException('Failed to get intraday margin setting',
        response.statusCode, response.body);
  }
}
