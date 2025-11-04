import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/convert_quote.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/convert_trade.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Creates a convert quote.
///
/// POST /api/v3/brokerage/convert/quote
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/convert/create-convert-quote
///
/// [fromAccount] - The account to convert from.
/// [toAccount] - The account to convert to.
/// [amount] - The amount to convert.
/// [tradeIncentiveMetadata] - The trade incentive metadata.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [ConvertQuote] object.
Future<ConvertQuote?> createConvertQuote(
    {required String fromAccount,
    required String toAccount,
    required String amount,
    Map<String, dynamic>? tradeIncentiveMetadata,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {
    'from_account': fromAccount,
    'to_account': toAccount,
    'amount': amount,
  };
  if (tradeIncentiveMetadata != null) {
    body['trade_incentive_metadata'] = jsonEncode(tradeIncentiveMetadata);
  }

  http.Response response = await postAuthorized('/convert/quote',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return ConvertQuote.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Commits a convert trade.
///
/// POST /api/v3/brokerage/convert/trade/{trade_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/convert/commit-convert-trade
///
/// [tradeId] - The ID of the trade to commit.
/// [fromAccount] - The account to convert from.
/// [toAccount] - The account to convert to.
/// [amount] - The amount to convert.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [ConvertTrade] object.
Future<ConvertTrade?> commitConvertTrade(
    {required String tradeId,
    required String fromAccount,
    required String toAccount,
    required String amount,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {
    'from_account': fromAccount,
    'to_account': toAccount,
    'amount': amount,
  };

  http.Response response = await postAuthorized('/convert/trade/$tradeId',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return ConvertTrade.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets a convert trade.
///
/// GET /api/v3/brokerage/convert/trade/{trade_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/convert/get-convert-trade
///
/// [tradeId] - The ID of the trade to get.
/// [fromAccount] - The account to convert from.
/// [toAccount] - The account to convert to.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [ConvertTrade] object.
Future<ConvertTrade?> getConvertTrade(
    {required String tradeId,
    required String fromAccount,
    required String toAccount,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {
    'from_account': fromAccount,
    'to_account': toAccount,
  };

  http.Response response = await getAuthorized('/convert/trade/$tradeId',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return ConvertTrade.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}
