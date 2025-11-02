import 'dart:convert';

import 'package:coinbase_pro_sdk/src/models/credential.dart';
import 'package:coinbase_pro_sdk/src/models/order.dart';
import 'package:coinbase_pro_sdk/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of orders for the current user.
///
/// This function makes a GET request to the /orders endpoint of the Coinbase Pro
/// API.
///
/// [limit] - A limit on the number of orders to be returned.
/// [status] - The status of the orders to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Order] objects.
Future<List<Order>> getOrders(
    {int limit = 1000,
    String status = 'all',
    required Credential credential,
    bool isSandbox = false}) async {
  List<Order> orders = [];

  Map<String, dynamic>? queryParameters = {'limit': '$limit', 'status': status};

  http.Response response = await getAuthorized('/orders',
      queryParameters: queryParameters,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);

    for (var jsonObject in jsonResponse) {
      orders.add(Order.fromCBJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return orders;
}

/// Gets a single order for the current user by order ID.
///
/// This function makes a GET request to the /orders/{order_id} endpoint of the
/// Coinbase Pro API.
///
/// [orderId] - The ID of the order to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Order] object, or null if no order is found for the given
/// order ID.
Future<Order?> getOrder(
    {required String orderId,
    required Credential credential,
    bool isSandbox = false}) async {
  Order? order;

  http.Response response = await getAuthorized('/orders/$orderId',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    order = Order.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return order;
}

/// Gets a single order for the current user by client OID.
///
/// This function makes a GET request to the /orders/client:{client_oid} endpoint
/// of the Coinbase Pro API.
///
/// [clientOid] - The client OID of the order to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Order] object, or null if no order is found for the given
/// client OID.
Future<Order?> getOrderByClientOid(
    {required String clientOid,
    required Credential credential,
    bool isSandbox = false}) async {
  Order? order;

  http.Response response = await getAuthorized('/orders/client:$clientOid',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    order = Order.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return order;
}

/// Creates a new order.
///
/// This function makes a POST request to the /orders endpoint of the Coinbase
/// Pro API.
///
/// [side] - The side of the order ('buy' or 'sell').
/// [productId] - The product ID to place the order for.
/// [profileId] - The profile ID to place the order for.
/// [type] - The type of order ('limit', 'market', or 'stop').
/// [size] - The size of the order.
/// [price] - The price of the order.
/// [funds] - The amount of funds to use for the order.
/// [timeInForce] - The time in force for the order.
/// [stp] - The self-trade prevention flag for the order.
/// [stop] - The stop type for the order.
/// [stopPrice] - The stop price for the order.
/// [cancelAfter] - The cancel after time for the order.
/// [postOnly] - A flag to indicate that the order should only be a Limit order.
/// [clientOid] - A client-supplied order ID.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns an [Order] object, or null if the order could not be created.
Future<Order?> createOrder(
    {required String side,
    required String productId,
    String? profileId,
    String? type,
    num? size,
    num? price,
    num? funds,
    String? timeInForce,
    String? stp,
    String? stop,
    num? stopPrice,
    String? cancelAfter,
    bool? postOnly,
    String? clientOid,
    required Credential credential,
    bool isSandbox = false}) async {
  Order? order;

  Map<String, dynamic>? body = {
    'side': side,
    'product_id': productId,
  };

  (profileId != null) ? body.addAll({'profile_id': profileId}) : null;
  (type != null && _validType(type)) ? body.addAll({'type': type}) : null;
  (size != null) ? body.addAll({'size': size}) : null;
  (price != null) ? body.addAll({'price': price}) : null;
  (funds != null) ? body.addAll({'funds': funds}) : null;
  if (timeInForce != null && _validTIF(timeInForce)) {
    body.addAll({'time_in_force': timeInForce});
  }
  (stp != null && _validSTP(stp)) ? body.addAll({'stp': stp}) : null;
  (stop != null && _validStop(stop)) ? body.addAll({'stop': stop}) : null;
  (stopPrice != null) ? body.addAll({'stop_price': stopPrice}) : null;
  if (cancelAfter != null && _validCA(cancelAfter)) {
    body.addAll({'cancel_after': cancelAfter});
  }
  (postOnly != null) ? body.addAll({'post_only': postOnly}) : null;
  (clientOid != null) ? body.addAll({'client_oid': clientOid}) : null;

  http.Response response = await postAuthorized('/orders',
      body: body, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    order = Order.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return order;
}

/// Cancels a single order.
///
/// This function makes a DELETE request to the /orders/{order_id} endpoint of
/// the Coinbase Pro API.
///
/// [orderId] - The ID of the order to be canceled.
/// [profileId] - The profile ID of the order to be canceled.
/// [productId] - The product ID of the order to be canceled.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns true if the order was canceled successfully, false otherwise.
Future<bool> cancelOrder(
    {required String orderId,
    String? profileId,
    String? productId,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic>? queryParameters = {};

  (profileId != null)
      ? queryParameters.addAll({'profile_id': profileId})
      : queryParameters.addAll({'profile_id': 'default'});
  (productId != null)
      ? queryParameters.addAll({'product_id': productId})
      : null;

  http.Response response = await deleteAuthorized('/orders/$orderId',
      queryParameters: queryParameters,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    print('Order $data Cancelled Successfully');
    return true;
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return false;
}

/// Checks if the given order type is valid.
///
/// [type] - The order type to check.
///
/// Returns true if the order type is valid, false otherwise.
bool _validType(String type) {
  if (type == 'limit') return true;
  if (type == 'market') return true;
  if (type == 'stop') return true;
  return false;
}

/// Checks if the given time in force is valid.
///
/// [timeInForce] - The time in force to check.
///
/// Returns true if the time in force is valid, false otherwise.
bool _validTIF(String timeInForce) {
  if (timeInForce == 'GTC') return true;
  if (timeInForce == 'GTT') return true;
  if (timeInForce == 'IOC') return true;
  if (timeInForce == 'FOK') return true;
  return false;
}

/// Checks if the given self-trade prevention flag is valid.
///
/// [stp] - The self-trade prevention flag to check.
///
/// Returns true if the self-trade prevention flag is valid, false otherwise.
bool _validSTP(String stp) {
  if (stp == 'dc') return true;
  if (stp == 'co') return true;
  if (stp == 'cn') return true;
  if (stp == 'cb') return true;
  return false;
}

/// Checks if the given stop type is valid.
///
/// [stop] - The stop type to check.
///
/// Returns true if the stop type is valid, false otherwise.
bool _validStop(String stop) {
  if (stop == 'loss') return true;
  if (stop == 'entry') return true;
  return false;
}

/// Checks if the given cancel after time is valid.
///
/// [cancelAfter] - The cancel after time to check.
///
/// Returns true if the cancel after time is valid, false otherwise.
bool _validCA(String cancelAfter) {
  if (cancelAfter == 'min') return true;
  if (cancelAfter == 'hour') return true;
  if (cancelAfter == 'day') return true;
  return false;
}
