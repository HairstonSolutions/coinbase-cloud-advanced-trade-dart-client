import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/cancel_pending_futures_sweep.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/close_position_result.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/current_margin_window.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/futures_balance_summary.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/futures_position.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/futures_positions.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/futures_sweeps.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/intraday_margin_setting.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/schedule_futures_sweep.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets the futures balance summary.
///
/// GET /api/v3/brokerage/cfm/balance_summary
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-futures-balance-summary
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [FuturesBalanceSummary] object.
Future<FuturesBalanceSummary?> getFuturesBalanceSummary(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/cfm/balance_summary',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return FuturesBalanceSummary.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets a list of futures positions.
///
/// GET /api/v3/brokerage/cfm/positions
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/list-futures-positions
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [FuturesPositions] object.
Future<FuturesPositions?> listFuturesPositions(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/cfm/positions',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return FuturesPositions.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets a futures position.
///
/// GET /api/v3/brokerage/cfm/positions/{product_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-futures-position
///
/// [productId] - The product ID to get the position for.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [FuturesPosition] object.
Future<FuturesPosition?> getFuturesPosition(
    {required String productId,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/cfm/positions/$productId',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return FuturesPosition.fromCBJson(jsonResponse['position']);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Schedules a futures sweep.
///
/// POST /api/v3/brokerage/cfm/sweeps/schedule
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/schedule-futures-sweep
///
/// [usdAmount] - The amount of USD to sweep.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [ScheduleFuturesSweep] object.
Future<ScheduleFuturesSweep?> scheduleFuturesSweep(
    {String? usdAmount,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {};
  if (usdAmount != null) {
    body['usd_amount'] = usdAmount;
  }

  http.Response response = await postAuthorized('/cfm/sweeps/schedule',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return ScheduleFuturesSweep.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets a list of futures sweeps.
///
/// GET /api/v3/brokerage/cfm/sweeps
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/list-futures-sweeps
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [FuturesSweeps] object.
Future<FuturesSweeps?> listFuturesSweeps(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/cfm/sweeps',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return FuturesSweeps.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Cancels a pending futures sweep.
///
/// DELETE /api/v3/brokerage/cfm/sweeps
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/cancel-pending-futures-sweep
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [CancelPendingFuturesSweep] object.
Future<CancelPendingFuturesSweep?> cancelPendingFuturesSweep(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await deleteAuthorized('/cfm/sweeps',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return CancelPendingFuturesSweep.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets the intraday margin setting.
///
/// GET /api/v3/brokerage/cfm/intraday/margin_setting
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-intraday-margin-setting
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [IntradayMarginSetting] object.
Future<IntradayMarginSetting?> getIntradayMarginSetting(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/cfm/intraday/margin_setting',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return IntradayMarginSetting.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Sets the intraday margin setting.
///
/// POST /api/v3/brokerage/cfm/intraday/margin_setting
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/set-intraday-margin-settings
///
/// [enabled] - Whether to enable intraday margin.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [IntradayMarginSetting] object.
Future<IntradayMarginSetting?> setIntradayMarginSetting(
    {required bool enabled,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {'enabled': enabled.toString()};

  http.Response response = await postAuthorized('/cfm/intraday/margin_setting',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return IntradayMarginSetting.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Gets the current margin window.
///
/// GET /api/v3/brokerage/cfm/intraday/current_margin_window
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-current-margin-window
///
/// [marginProfileType] - The margin profile type.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [CurrentMarginWindow] object.
Future<CurrentMarginWindow?> getCurrentMarginWindow(
    {String? marginProfileType,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {};
  if (marginProfileType != null) {
    queryParameters.addAll({'margin_profile_type': marginProfileType});
  }

  http.Response response = await getAuthorized(
      '/cfm/intraday/current_margin_window',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return CurrentMarginWindow.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Closes a futures position.
///
/// POST /api/v3/brokerage/orders/close_position
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/close-position
///
/// [clientOrderId] - The client order ID.
/// [productId] - The product ID.
/// [size] - The size to close.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [ClosePositionResult] object.
Future<ClosePositionResult?> closeFuturesPosition(
    {required String clientOrderId,
    required String productId,
    String? size,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {
    'client_order_id': clientOrderId,
    'product_id': productId,
  };
  if (size != null) body['size'] = size;

  http.Response response = await postAuthorized('/orders/close_position',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return ClosePositionResult.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}
