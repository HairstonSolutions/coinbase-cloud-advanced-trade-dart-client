import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/portfolio.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of portfolios for the current user.
///
/// GET /api/v3/brokerage/portfolios
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/list-portfolios
///
/// This function makes a GET request to the /portfolios endpoint of the Coinbase
/// Advanced Trade API.
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Portfolio] objects.
Future<List<Portfolio>> listPortfolios(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  List<Portfolio> portfolios = [];

  http.Response response = await getAuthorized('/portfolios',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonPortfolios = jsonResponse['portfolios'];

    for (var jsonObject in jsonPortfolios) {
      portfolios.add(Portfolio.fromCBJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return portfolios;
}

/// Creates a new portfolio.
///
/// POST /api/v3/brokerage/portfolios
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/create-portfolio
///
/// This function makes a POST request to the /portfolios endpoint of the Coinbase
/// Advanced Trade API.
///
/// [name] - The name of the portfolio to be created.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Portfolio] object.
Future<Portfolio?> createPortfolio(
    {required String name,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> body = {'name': name};

  http.Response response = await postAuthorized('/portfolios',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return Portfolio.fromCBJson(jsonResponse['portfolio']);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Edits a portfolio.
///
/// PUT /api/v3/brokerage/portfolios/{portfolio_uuid}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/edit-portfolio
///
/// This function makes a PUT request to the /portfolios/{uuid} endpoint of the
/// Coinbase Advanced Trade API.
///
/// [uuid] - The UUID of the portfolio to be edited.
/// [name] - The new name of the portfolio.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Portfolio] object.
Future<Portfolio?> editPortfolio(
    {required String uuid,
    required String name,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> body = {'name': name};

  http.Response response = await putAuthorized('/portfolios/$uuid',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return Portfolio.fromCBJson(jsonResponse['portfolio']);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Deletes a portfolio.
///
/// DELETE /api/v3/brokerage/portfolios/{portfolio_uuid}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/delete-portfolio
///
/// This function makes a DELETE request to the /portfolios/{uuid} endpoint of the
/// Coinbase Advanced Trade API.
///
/// [uuid] - The UUID of the portfolio to be deleted.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns true if the portfolio was deleted successfully.
Future<bool> deletePortfolio(
    {required String uuid,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await deleteAuthorized('/portfolios/$uuid',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    return true;
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
    return false;
  }
}

/// Moves funds between portfolios.
///
/// POST /api/v3/brokerage/portfolios/move_funds
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/move-portfolios-funds
///
/// This function makes a POST request to the /portfolios/move_funds endpoint of the
/// Coinbase Advanced Trade API.
///
/// [funds] - A map containing the amount and currency of the funds to be moved.
/// [sourcePortfolioUuid] - The UUID of the source portfolio.
/// [targetPortfolioUuid] - The UUID of the target portfolio.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns true if the funds were moved successfully.
Future<bool> movePortfolioFunds(
    {required Map<String, String> funds,
    required String sourcePortfolioUuid,
    required String targetPortfolioUuid,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> body = {
    'funds': funds,
    'source_portfolio_uuid': sourcePortfolioUuid,
    'target_portfolio_uuid': targetPortfolioUuid
  };

  http.Response response = await postAuthorized('/portfolios/move_funds',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    return true;
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
    return false;
  }
}
