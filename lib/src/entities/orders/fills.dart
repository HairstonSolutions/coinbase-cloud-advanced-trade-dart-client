import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/fill.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
import 'package:http/http.dart' as http;

Future<List<Fill>> getFills(
    {required String productId,
    int limit = 100,
    String profileId = 'default',
    required Credential credential,
    bool isSandbox = false}) async {
  List<Fill> fills = [];

  Map<String, dynamic>? queryParameters = {
    "profile_id": profileId,
    "limit": '$limit',
    "product_id": productId
  };

  http.Response response = await getAuthorized('/fills',
      queryParameters: queryParameters,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);

    for (var jsonObject in jsonResponse) {
      fills.add(Fill.convertJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
  }

  return fills;
}

Future<List<Fill>> getFillsByOrderId(String orderID,
    {String profileId = 'default',
    required Credential credential,
    bool isSandbox = false}) async {
  List<Fill> fills = [];

  Map<String, dynamic>? queryParameters = {
    "profile_id": profileId,
    "order_id": orderID
  };

  http.Response response = await getAuthorized('/fills',
      queryParameters: queryParameters,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);

    for (var jsonObject in jsonResponse) {
      fills.add(Fill.convertJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return fills;
}
