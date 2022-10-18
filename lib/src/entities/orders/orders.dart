import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/order.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
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
    print('Request to URL $url failed.');
  }

  return orders;
}
