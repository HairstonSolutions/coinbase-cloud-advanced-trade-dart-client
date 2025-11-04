import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/cancel_orders.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/close_position_result.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/edit_order_result.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/edit_preview_order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/fill.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_result.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/preview_order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Creates an order.
///
/// POST /api/v3/brokerage/orders
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/create-order
///
/// [clientOrderId] - The client order ID.
/// [productId] - The product ID.
/// [side] - The side of the order (BUY or SELL).
/// [orderConfiguration] - The configuration of the order.
/// [leverage] - The leverage to use.
/// [marginType] - The margin type to use.
/// [retailPortfolioId] - The retail portfolio ID.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [OrderResult] object.
Future<OrderResult?> createOrder(
    {String? clientOrderId,
    required String productId,
    required String side,
    required Map<String, dynamic> orderConfiguration,
    String? leverage,
    String? marginType,
    String? retailPortfolioId,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {
    'product_id': productId,
    'side': side,
    'order_configuration': orderConfiguration,
  };
  if (clientOrderId != null) body['client_order_id'] = clientOrderId;
  if (leverage != null) body['leverage'] = leverage;
  if (marginType != null) body['margin_type'] = marginType;
  if (retailPortfolioId != null) {
    body['retail_portfolio_id'] = retailPortfolioId;
  }

  http.Response response = await postAuthorized('/orders',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return OrderResult.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Cancels a batch of orders.
///
/// POST /api/v3/brokerage/orders/batch_cancel
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/cancel-order
///
/// [orderIds] - A list of order IDs to cancel.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [CancelOrders] object.
Future<CancelOrders?> cancelOrders(
    {required List<String> orderIds,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {'order_ids': orderIds};

  http.Response response = await postAuthorized('/orders/batch_cancel',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return CancelOrders.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Previews an order.
///
/// POST /api/v3/brokerage/orders/preview
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/preview-orders
///
/// [productId] - The product ID.
/// [side] - The side of the order (BUY or SELL).
/// [orderConfiguration] - The configuration of the order.
/// [leverage] - The leverage to use.
/// [marginType] - The margin type to use.
/// [retailPortfolioId] - The retail portfolio ID.
/// [attachedOrderConfiguration] - The attached order configuration.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PreviewOrder] object.
Future<PreviewOrder?> previewOrder(
    {required String productId,
    required String side,
    required Map<String, dynamic> orderConfiguration,
    String? leverage,
    String? marginType,
    String? retailPortfolioId,
    Map<String, dynamic>? attachedOrderConfiguration,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {
    'product_id': productId,
    'side': side,
    'order_configuration': orderConfiguration,
  };
  if (leverage != null) body['leverage'] = leverage;
  if (marginType != null) body['margin_type'] = marginType;
  if (retailPortfolioId != null) {
    body['retail_portfolio_id'] = retailPortfolioId;
  }
  if (attachedOrderConfiguration != null) {
    body['attached_order_configuration'] =
        jsonEncode(attachedOrderConfiguration);
  }

  http.Response response = await postAuthorized('/orders/preview',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PreviewOrder.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Edits an order.
///
/// POST /api/v3/brokerage/orders/edit
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/edit-order
///
/// [orderId] - The ID of the order to edit.
/// [price] - The new price for the order.
/// [size] - The new size for the order.
/// [attachedOrderConfiguration] - The attached order configuration.
/// [cancelAttachedOrder] - Whether to cancel the attached order.
/// [stopPrice] - The new stop price for the order.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [EditOrderResult] object.
Future<EditOrderResult?> editOrder(
    {required String orderId,
    required String price,
    required String size,
    Map<String, dynamic>? attachedOrderConfiguration,
    bool? cancelAttachedOrder,
    String? stopPrice,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {
    'order_id': orderId,
    'price': price,
    'size': size,
  };
  if (attachedOrderConfiguration != null) {
    body['attached_order_configuration'] =
        jsonEncode(attachedOrderConfiguration);
  }
  if (cancelAttachedOrder != null) {
    body['cancel_attached_order'] = cancelAttachedOrder.toString();
  }
  if (stopPrice != null) body['stop_price'] = stopPrice;

  http.Response response = await postAuthorized('/orders/edit',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return EditOrderResult.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Previews an order edit.
///
/// POST /api/v3/brokerage/orders/edit_preview
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/edit-order-preview
///
/// [orderId] - The ID of the order to edit.
/// [price] - The new price for the order.
/// [size] - The new size for the order.
/// [attachedOrderConfiguration] - The attached order configuration.
/// [cancelAttachedOrder] - Whether to cancel the attached order.
/// [stopPrice] - The new stop price for the order.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [EditPreviewOrder] object.
Future<EditPreviewOrder?> editOrderPreview(
    {required String orderId,
    required String price,
    required String size,
    Map<String, dynamic>? attachedOrderConfiguration,
    bool? cancelAttachedOrder,
    String? stopPrice,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var body = {
    'order_id': orderId,
    'price': price,
    'size': size,
  };
  if (attachedOrderConfiguration != null) {
    body['attached_order_configuration'] =
        jsonEncode(attachedOrderConfiguration);
  }
  if (cancelAttachedOrder != null) {
    body['cancel_attached_order'] = cancelAttachedOrder.toString();
  }
  if (stopPrice != null) body['stop_price'] = stopPrice;

  http.Response response = await postAuthorized('/orders/edit_preview',
      body: jsonEncode(body),
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return EditPreviewOrder.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}

/// Closes a position.
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
Future<ClosePositionResult?> closePosition(
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

/// Gets a list of orders.
///
/// GET /api/v3/brokerage/orders/historical/batch
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-orders
///
/// [productId] - The product ID.
/// [orderStatus] - The status of the orders to return.
/// [limit] - The number of orders to return.
/// [startDate] - The start date.
/// [endDate] - The end date.
/// [userNativeCurrency] - The user native currency.
/// [orderType] - The type of the order.
/// [orderSide] - The side of the order (BUY or SELL).
/// [cursor] - The cursor for pagination.
/// [productType] - The type of the product.
/// [orderPlacementSource] - The source of the order placement.
/// [contractExpiryType] - The contract expiry type.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Order] objects.
Future<List<Order>> getOrders(
    {String? productId,
    List<String>? orderStatus,
    int? limit,
    DateTime? startDate,
    DateTime? endDate,
    String? userNativeCurrency,
    String? orderType,
    String? orderSide,
    String? cursor,
    String? productType,
    String? orderPlacementSource,
    String? contractExpiryType,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var queryParameters = <String, String>{};
  if (productId != null) queryParameters['product_id'] = productId;
  if (orderStatus != null) queryParameters['order_status'] = orderStatus.join(',');
  if (limit != null) queryParameters['limit'] = limit.toString();
  if (startDate != null) queryParameters['start_date'] = startDate.toIso8601String();
  if (endDate != null) queryParameters['end_date'] = endDate.toIso8601String();
  if (userNativeCurrency != null) queryParameters['user_native_currency'] = userNativeCurrency;
  if (orderType != null) queryParameters['order_type'] = orderType;
  if (orderSide != null) queryParameters['order_side'] = orderSide;
  if (cursor != null) queryParameters['cursor'] = cursor;
  if (productType != null) queryParameters['product_type'] = productType;
  if (orderPlacementSource != null) queryParameters['order_placement_source'] = orderPlacementSource;
  if (contractExpiryType != null) queryParameters['contract_expiry_type'] = contractExpiryType;

  http.Response response = await getAuthorized('/orders/historical/batch',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var orders = <Order>[];
    for (var order in jsonResponse['orders']) {
      orders.add(Order.fromCBJson(order));
    }
    return orders;
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
    return [];
  }
}

/// Gets a list of fills.
///
/// GET /api/v3/brokerage/orders/historical/fills
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-fills
///
/// [orderId] - The ID of the order to get fills for.
/// [productId] - The product ID.
/// [startSequenceTimestamp] - The start sequence timestamp.
/// [endSequenceTimestamp] - The end sequence timestamp.
/// [limit] - The number of fills to return.
/// [cursor] - The cursor for pagination.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Fill] objects.
Future<List<Fill>> getFills(
    {String? orderId,
    String? productId,
    DateTime? startSequenceTimestamp,
    DateTime? endSequenceTimestamp,
    int? limit,
    String? cursor,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var queryParameters = <String, String>{};
  if (orderId != null) queryParameters['order_id'] = orderId;
  if (productId != null) queryParameters['product_id'] = productId;
  if (startSequenceTimestamp != null) {
    queryParameters['start_sequence_timestamp'] =
        startSequenceTimestamp.toIso8601String();
  }
  if (endSequenceTimestamp != null) {
    queryParameters['end_sequence_timestamp'] =
        endSequenceTimestamp.toIso8601String();
  }
  if (limit != null) queryParameters['limit'] = limit.toString();
  if (cursor != null) queryParameters['cursor'] = cursor;

  http.Response response = await getAuthorized('/orders/historical/fills',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var fills = <Fill>[];
    for (var fill in jsonResponse['fills']) {
      fills.add(Fill.fromCBJson(fill));
    }
    return fills;
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
    return [];
  }
}

/// Gets an order.
///
/// GET /api/v3/brokerage/orders/historical/{order_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/get-order
///
/// [orderId] - The ID of the order to get.
/// [clientOrderId] - The client order ID.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Order] object.
Future<Order?> getOrder(
    {required String orderId,
    String? clientOrderId,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  var queryParameters = <String, String>{};
  if (clientOrderId != null) queryParameters['client_order_id'] = clientOrderId;

  http.Response response = await getAuthorized('/orders/historical/$orderId',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return Order.fromCBJson(jsonResponse['order']);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}
