import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/pro/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/pro/models/order.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/pro/services/network.dart';
import 'package:http/http.dart' as http;

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
      orders.add(Order.convertJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return orders;
}

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
    order = Order.convertJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return order;
}

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
    order = Order.convertJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return order;
}

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
    order = Order.convertJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return order;
}

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
      isSandbox: true);

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

bool _validType(String type) {
  if (type == 'limit') return true;
  if (type == 'market') return true;
  if (type == 'stop') return true;
  return false;
}

bool _validTIF(String timeInForce) {
  if (timeInForce == 'GTC') return true;
  if (timeInForce == 'GTT') return true;
  if (timeInForce == 'IOC') return true;
  if (timeInForce == 'FOK') return true;
  return false;
}

bool _validSTP(String stp) {
  if (stp == 'dc') return true;
  if (stp == 'co') return true;
  if (stp == 'cn') return true;
  if (stp == 'cb') return true;
  return false;
}

bool _validStop(String stop) {
  if (stop == 'loss') return true;
  if (stop == 'entry') return true;
  return false;
}

bool _validCA(String cancelAfter) {
  if (cancelAfter == 'min') return true;
  if (cancelAfter == 'hour') return true;
  if (cancelAfter == 'day') return true;
  return false;
}
