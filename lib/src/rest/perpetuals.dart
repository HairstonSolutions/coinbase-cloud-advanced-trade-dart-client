import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/perpetuals.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets the perpetuals portfolio summary.
///
/// GET /api/v3/brokerage/intx/portfolio/{portfolio_uuid}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/get-perpetuals-portfolio-summary
///
/// [portfolioUuid] - The portfolio UUID.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PerpetualsPortfolioSummary] object.
Future<PerpetualsPortfolioSummary?> getPerpetualsPortfolioSummary(
    {required String portfolioUuid,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/intx/portfolio/$portfolioUuid',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PerpetualsPortfolioSummary.fromJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Opt In or Out of Multi Asset Collateral.
///
/// POST /api/v3/brokerage/intx/multi_asset_collateral
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/opt-in-or-out
///
/// [portfolioUuid] - The portfolio UUID.
/// [enabled] - Enable or disable Multi Asset Collateral.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns true if the operation was successful.
Future<bool> setMultiAssetCollateral(
    {required String portfolioUuid,
    required bool enabled,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> body = {
    'portfolio_uuid': portfolioUuid,
    'multi_asset_collateral_enabled': enabled,
  };

  http.Response response = await postAuthorized('/intx/multi_asset_collateral',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['multi_asset_collateral_enabled'];
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
    return false;
  }
}

/// Gets a list of asset balances on Intx for a given Portfolio.
///
/// GET /api/v3/brokerage/intx/balances/{portfolio_uuid}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/get-portfolio-balances
///
/// [portfolioUuid] - The portfolio UUID.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PortfolioBalances] object.
Future<PortfolioBalances?> getPortfolioBalances(
    {required String portfolioUuid,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/intx/balances/$portfolioUuid',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PortfolioBalances.fromJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets a specific open position on Intx.
///
/// GET /api/v3/brokerage/intx/positions/{portfolio_uuid}/{symbol}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/get-perpetuals-position
///
/// [portfolioUuid] - The portfolio UUID.
/// [symbol] - The trading pair (e.g. 'BTC-PERP-INTX').
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PerpetualsPosition] object.
Future<PerpetualsPosition?> getPerpetualsPosition(
    {required String portfolioUuid,
    required String symbol,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized(
      '/intx/positions/$portfolioUuid/$symbol',
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PerpetualsPosition.fromJson(jsonResponse['position']);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets a list of open positions in your Perpetuals portfolio.
///
/// GET /api/v3/brokerage/intx/positions/{portfolio_uuid}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/list-perpetuals-positions
///
/// [portfolioUuid] - The portfolio UUID.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PerpetualsPositions] object.
Future<PerpetualsPositions?> listPerpetualsPositions(
    {required String portfolioUuid,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/intx/positions/$portfolioUuid',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PerpetualsPositions.fromJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}
