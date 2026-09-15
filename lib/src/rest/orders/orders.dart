import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/cancel_orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/coinbase_http_options.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_preview_response.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/create_order_result.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_response.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_side.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/preview_order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/page.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/stop_direction.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/logger.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/pagination.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logging/logging.dart';

final Logger _logger = setupLogger('OrdersRest');

/// Gets a single page of historical orders for the current user.
///
/// GET /v3/brokerage/orders/historical/batch
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-orders
///
/// This function makes a GET request to the /orders/historical/batch endpoint
/// of the Coinbase Advanced Trade API. It supports pagination using a cursor.
///
/// [limit] - A limit on the number of orders to be returned.
/// [cursor] - A cursor for pagination.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [Page] of [Order] objects.
Future<Page<Order>> getOrdersPage({
  int? limit = 1000,
  List<String>? productIds,
  List<String>? orderStatus,
  String? orderSide,
  String? orderType,
  String? orderPlacementSource,
  String? contractExpiryType,
  List<String>? assetFilters,
  List<String>? timeInForces,
  String? startDate,
  String? endDate,
  String? sortBy,
  String? retailPortfolioId,
  String? cursor,
  http.Client? client,
  CoinbaseHttpOptions? options,
  required Credential credential,
  bool isSandbox = false,
}) async {
  List<Order> orders = [];
  Map<String, dynamic> queryParameters = {'limit': '$limit'};
  if (productIds != null && productIds.isNotEmpty) {
    queryParameters['product_ids'] = productIds;
  }
  if (orderStatus != null && orderStatus.isNotEmpty) {
    queryParameters['order_status'] = orderStatus;
  }
  if (orderSide != null) {
    queryParameters['order_side'] = orderSide;
  }
  if (orderType != null) {
    queryParameters['order_types'] = orderType;
  }
  if (orderPlacementSource != null) {
    queryParameters['order_placement_source'] = orderPlacementSource;
  }
  if (contractExpiryType != null) {
    queryParameters['contract_expiry_type'] = contractExpiryType;
  }
  if (assetFilters != null && assetFilters.isNotEmpty) {
    queryParameters['asset_filters'] = assetFilters;
  }
  if (timeInForces != null && timeInForces.isNotEmpty) {
    queryParameters['time_in_forces'] = timeInForces;
  }
  if (startDate != null) {
    queryParameters['start_date'] = startDate;
  }
  if (endDate != null) {
    queryParameters['end_date'] = endDate;
  }
  if (sortBy != null) {
    queryParameters['sort_by'] = sortBy;
  }
  if (retailPortfolioId != null) {
    queryParameters['retail_portfolio_id'] = retailPortfolioId;
  }
  if (cursor != null) {
    queryParameters['cursor'] = cursor;
  }

  http.Response response = await getAuthorized(
    '/orders/historical/batch',
    queryParameters: queryParameters,
    client: client,
    options: options,
    credential: credential,
    isSandbox: isSandbox,
  );

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonAccounts = jsonResponse['orders'];
    String? jsonCursor = jsonResponse['cursor'];
    bool hasNext = jsonResponse['has_next'] ?? false;

    for (var jsonObject in jsonAccounts) {
      orders.add(Order.fromCBJson(jsonObject));
    }

    return Page<Order>(
      items: orders,
      nextCursor: jsonCursor,
      hasNext: hasNext,
    );
  } else {
    throw CoinbaseException(
      'Failed to get orders page',
      response.statusCode,
      response.body,
    );
  }
}

/// Gets a list of historical orders for the current user.
///
/// GET /v3/brokerage/orders/historical/batch
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-orders
///
/// This function makes a GET request to the /orders/historical/batch endpoint
/// of the Coinbase Advanced Trade API. It supports pagination using a cursor.
/// Pages are followed while the response reports `has_next` and returns a new
/// cursor, so a final page that still carries a cursor ends the loop.
///
/// [limit] - A limit on the number of orders to be returned.
/// [cursor] - A cursor for pagination.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Order] objects.
Future<List<Order>> getOrders({
  int? limit = 1000,
  List<String>? productIds,
  List<String>? orderStatus,
  String? orderSide,
  String? orderType,
  String? orderPlacementSource,
  String? contractExpiryType,
  List<String>? assetFilters,
  List<String>? timeInForces,
  String? startDate,
  String? endDate,
  String? sortBy,
  String? retailPortfolioId,
  String? cursor,
  http.Client? client,
  CoinbaseHttpOptions? options,
  required Credential credential,
  bool isSandbox = false,
}) async {
  List<Order> orders = [];
  String? currentCursor = cursor;

  while (true) {
    Page<Order> page = await getOrdersPage(
      limit: limit,
      productIds: productIds,
      orderStatus: orderStatus,
      orderSide: orderSide,
      orderType: orderType,
      orderPlacementSource: orderPlacementSource,
      contractExpiryType: contractExpiryType,
      assetFilters: assetFilters,
      timeInForces: timeInForces,
      startDate: startDate,
      endDate: endDate,
      sortBy: sortBy,
      retailPortfolioId: retailPortfolioId,
      cursor: currentCursor,
      client: client,
      options: options,
      credential: credential,
      isSandbox: isSandbox,
    );

    orders.addAll(page.items);

    String? nextCursor = nextPageCursor(page, currentCursor);
    if (nextCursor == null) {
      break;
    }
    currentCursor = nextCursor;
  }

  return orders;
}

/// Gets a single historical order for the current user by order ID.
///
/// GET /v3/brokerage/orders/historical/{order_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/get-order
///
/// This function makes a GET request to the /orders/historical/{order_id}
/// endpoint of the Coinbase Advanced Trade API.
///
/// [orderId] - The ID of the order to be returned.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Order] object, or null if the API responds with a 404 for the
/// given order ID.
///
/// Throws a [CoinbaseException] for any other non-200 response.
Future<Order?> getOrder({
  required String orderId,
  http.Client? client,
  CoinbaseHttpOptions? options,
  required Credential credential,
  bool isSandbox = false,
}) async {
  Order? order;

  http.Response response = await getAuthorized(
    '/orders/historical/$orderId',
    client: client,
    options: options,
    credential: credential,
    isSandbox: isSandbox,
  );

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    var jsonOrder = jsonResponse['order'];
    order = Order.fromCBJson(jsonOrder);
  } else if (response.statusCode != 404) {
    throw CoinbaseException(
      'Failed to get order',
      response.statusCode,
      response.body,
    );
  }

  return order;
}

/// Creates a market order. IOC: Immediate or Cancel.
/// Buy or sell a specified quantity of an Asset at the current best available market price.
///
/// POST /v3/brokerage/orders
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/create-order
///
/// [clientOrderId] - A unique ID for the order, generated by the client.
/// [productId] - The ID of the product to trade.
/// [side] - The side of the order (BUY or SELL).
/// [quoteSize] - The amount of quote currency to spend on a BUY order, or the
/// amount of base currency to sell on a SELL order. Serialized with
/// [Decimal.toString], which never emits an exponent or a grouping separator.
/// [baseSize] - The amount of base currency to buy on a BUY order, or the
/// amount of quote currency to receive on a SELL order. Serialized with
/// [Decimal.toString], which never emits an exponent or a grouping separator.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a map containing the result of the order creation, or null if the
/// request fails.
Future<CreateOrderResult> createMarketOrder({
  required String clientOrderId,
  required String productId,
  required OrderSide side,
  Decimal? quoteSize,
  Decimal? baseSize,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  if (quoteSize == null && baseSize == null) {
    throw ArgumentError('Either quoteSize or baseSize must be provided.');
  }
  if (quoteSize != null && baseSize != null) {
    throw ArgumentError('Only one of quoteSize or baseSize can be provided.');
  }

  // Market IOC: Buy or sell a specified quantity of an Asset at the current best available market price.
  Map<String, dynamic>? marketMarketIOC = {};

  (quoteSize != null)
      ? marketMarketIOC.addAll({'quote_size': quoteSize.toString()})
      : null;
  (baseSize != null)
      ? marketMarketIOC.addAll({'base_size': baseSize.toString()})
      : null;

  final orderConfiguration = {'market_market_ioc': marketMarketIOC};

  return _createOrder(
    clientOrderId: clientOrderId,
    productId: productId,
    side: side,
    orderConfiguration: orderConfiguration,
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );
}

/// Creates a limit order. GTC: Good Till Cancelled.
/// Buy or sell a specified quantity of an Asset at a specified price.
/// If posted, the Order will remain on the Order Book until canceled.
///
/// POST /v3/brokerage/orders
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/create-order
///
/// [clientOrderId] - A unique ID for the order, generated by the client.
/// [productId] - The ID of the product to trade.
/// [side] - The side of the order (BUY or SELL).
/// [baseSize] - The amount of base currency to buy or sell.
/// [limitPrice] - The price at which to buy or sell the base currency.
/// [postOnly] - Whether the order should be a post-only order.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a map containing the result of the order creation, or null if the
/// request fails.
Future<CreateOrderResult> createLimitOrder({
  required String clientOrderId,
  required String productId,
  required OrderSide side,
  required Decimal baseSize,
  required Decimal limitPrice,
  bool postOnly = false,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  final orderConfiguration = {
    'limit_limit_gtc': {
      'base_size': baseSize.toString(),
      'limit_price': limitPrice.toString(),
      'post_only': postOnly,
    },
  };

  return _createOrder(
    clientOrderId: clientOrderId,
    productId: productId,
    side: side,
    orderConfiguration: orderConfiguration,
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );
}

/// Creates a stop limit order. GTC: Good Till Cancelled.
/// An order that triggers a limit order when the last trade price hits a specified stop price.
///
/// POST /v3/brokerage/orders
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/create-order
///
/// [clientOrderId] - A unique ID for the order, generated by the client.
/// [productId] - The ID of the product to trade.
/// [side] - The side of the order (BUY or SELL).
/// [baseSize] - The amount of base currency to buy or sell.
/// [limitPrice] - The price at which to buy or sell the base currency.
/// [stopPrice] - The price at which the order should be triggered.
/// [stopDirection] - The direction of the stop price (ABOVE or BELOW).
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a map containing the result of the order creation, or null if the
/// request fails.
Future<CreateOrderResult> createStopLimitOrderGTC({
  required String clientOrderId,
  required String productId,
  required OrderSide side,
  required Decimal baseSize,
  required Decimal limitPrice,
  required Decimal stopPrice,
  required StopDirection stopDirection,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  final orderConfiguration = {
    'stop_limit_stop_limit_gtc': {
      'base_size': baseSize.toString(),
      'limit_price': limitPrice.toString(),
      'stop_price': stopPrice.toString(),
      'stop_direction': stopDirection.toCB(),
    },
  };

  return _createOrder(
    clientOrderId: clientOrderId,
    productId: productId,
    side: side,
    orderConfiguration: orderConfiguration,
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );
}

/// Creates a stop limit order. GTD: Good Till Date.
/// An order that triggers a limit order when the last trade price hits a specified stop price.
/// The order will be cancelled if it is not filled by the specified end time.
///
/// POST /v3/brokerage/orders
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/create-order
///
/// [clientOrderId] - A unique ID for the order, generated by the client.
/// [productId] - The ID of the product to trade.
/// [side] - The side of the order (BUY or SELL).
/// [baseSize] - The amount of base currency to buy or sell.
/// [limitPrice] - The price at which to buy or sell the base currency.
/// [stopPrice] - The price at which the order should be triggered.
/// [stopDirection] - The direction of the stop price (ABOVE or BELOW).
/// [endTime] - The time at which the order should be cancelled if it is not filled.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a map containing the result of the order creation, or null if the
/// request fails.
Future<CreateOrderResult> createStopLimitOrderGTD({
  required String clientOrderId,
  required String productId,
  required OrderSide side,
  required Decimal baseSize,
  required Decimal limitPrice,
  required Decimal stopPrice,
  required StopDirection stopDirection,
  required DateTime endTime,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  final orderConfiguration = {
    'stop_limit_stop_limit_gtd': {
      'base_size': baseSize.toString(),
      'limit_price': limitPrice.toString(),
      'stop_price': stopPrice.toString(),
      'stop_direction': stopDirection.toCB(),
      'end_time': endTime.toUtc().toIso8601String(),
    },
  };

  return _createOrder(
    clientOrderId: clientOrderId,
    productId: productId,
    side: side,
    orderConfiguration: orderConfiguration,
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );
}

Future<CreateOrderResult> _createOrder({
  required String clientOrderId,
  required String productId,
  required OrderSide side,
  required Map<String, dynamic> orderConfiguration,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  final body = {
    'client_order_id': clientOrderId,
    'product_id': productId,
    'side': side.toCB(),
    'order_configuration': orderConfiguration,
  };

  http.Response response = await postAuthorized(
    '/orders',
    body: jsonEncode(body),
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);

    bool isSuccess = jsonResponse['success'] == true;
    if (isSuccess) {
      return OrderSuccess.fromCBJson(jsonResponse);
    } else {
      return OrderRejected.fromCBJson(jsonResponse);
    }
  } else {
    throw CoinbaseException(
      'Failed to create order',
      response.statusCode,
      response.body,
    );
  }
}

/// Edit an order.
///
/// POST /v3/brokerage/orders/edit
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/edit-order
///
/// [orderId] - The ID of the order to edit.
/// [price] - The new price for the order.
/// [size] - The new size for the order.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [EditOrderResponse] object.
Future<EditOrderResponse> editOrder({
  required String orderId,
  required Decimal price,
  required Decimal size,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  final body = {
    'order_id': orderId,
    'price': price.toString(),
    'size': size.toString(),
  };

  http.Response response = await postAuthorized(
    '/orders/edit',
    body: jsonEncode(body),
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return EditOrderResponse.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
      'Failed to edit order',
      response.statusCode,
      response.body,
    );
  }
}

/// Edit an order preview.
///
/// POST /v3/brokerage/orders/edit_preview
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/edit-order-preview
///
/// [orderId] - The ID of the order to edit.
/// [price] - The new price for the order.
/// [size] - The new size for the order.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [EditOrderPreviewResponse] object.
Future<EditOrderPreviewResponse> editOrderPreview({
  required String orderId,
  required Decimal price,
  required Decimal size,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  final body = {
    'order_id': orderId,
    'price': price.toString(),
    'size': size.toString(),
  };

  http.Response response = await postAuthorized(
    '/orders/edit_preview',
    body: jsonEncode(body),
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return EditOrderPreviewResponse.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
      'Failed to preview edit order',
      response.statusCode,
      response.body,
    );
  }
}

/// Previews an order.
///
/// POST /v3/brokerage/orders/preview
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/preview-orders
///
/// [productId] - The ID of the product to trade.
/// [side] - The side of the order (BUY or SELL).
/// [orderConfiguration] - The configuration of the order.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PreviewOrderResponse] object.
Future<PreviewOrderResponse> previewOrder({
  required String productId,
  required OrderSide side,
  required Map<String, dynamic> orderConfiguration,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  final body = {
    'product_id': productId,
    'side': side.toCB(),
    'order_configuration': orderConfiguration,
  };

  http.Response response = await postAuthorized(
    '/orders/preview',
    body: jsonEncode(body),
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PreviewOrderResponse.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
      'Failed to preview order',
      response.statusCode,
      response.body,
    );
  }
}

/// Cancels a list of orders.
///
/// POST /v3/brokerage/orders/batch_cancel
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/cancel-order
///
/// [orderIds] - A list of order IDs to cancel.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [CanceledOrders] object.
Future<CanceledOrders?> cancelOrders({
  required List<String> orderIds,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  CanceledOrders? result;

  final body = {'order_ids': orderIds};

  http.Response response = await postAuthorized(
    '/orders/batch_cancel',
    body: jsonEncode(body),
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    result = CanceledOrders.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
      'Failed to cancel orders',
      response.statusCode,
      response.body,
    );
  }

  return result;
}

/// Closes a position for a given product ID.
///
/// POST /v3/brokerage/orders/close_position
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/close-position
///
/// [productId] - The ID of the product to close the position for.
/// [credential] - The user's API credentials.
/// [options] - Optional HTTP options such as a custom base URL, timeout,
/// and http client.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a map containing the result of the close position request.
Future<Map<String, dynamic>?> closePosition({
  required String productId,
  required Credential credential,
  bool isSandbox = false,
  Client? client,
  CoinbaseHttpOptions? options,
}) async {
  Map<String, dynamic>? result;

  final body = {'product_id': productId};

  http.Response response = await postAuthorized(
    '/orders/close_position',
    body: jsonEncode(body),
    credential: credential,
    isSandbox: isSandbox,
    client: client,
    options: options,
  );

  if (response.statusCode == 200) {
    var url = response.request?.url.toString();
    _logger.fine(
      'Request to URL $url Success: Response code ${response.statusCode}',
    );
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    result = jsonResponse;
  } else {
    throw CoinbaseException(
      'Failed to close position',
      response.statusCode,
      response.body,
    );
  }

  return result;
}
