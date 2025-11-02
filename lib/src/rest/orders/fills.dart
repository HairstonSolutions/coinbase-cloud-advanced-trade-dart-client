import 'dart:convert';

import 'package:coinbase_pro_sdk/src/models/credential.dart';
import 'package:coinbase_pro_sdk/src/models/fill.dart';
import 'package:coinbase_pro_sdk/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of recent fills for a given product.
///
/// This function makes a GET request to the /fills endpoint of the Coinbase Pro
/// API.
///
/// [productId] - The product ID to get fills for.
/// [limit] - A limit on the number of fills to be returned.
/// [profileId] - The profile ID to get fills for.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Fill] objects.
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
      fills.add(Fill.fromCBJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
  }

  return fills;
}

/// Gets a list of recent fills for a given order.
///
/// This function makes a GET request to the /fills endpoint of the Coinbase Pro
/// API.
///
/// [orderID] - The order ID to get fills for.
/// [profileId] - The profile ID to get fills for.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [Fill] objects.
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
      fills.add(Fill.fromCBJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }

  return fills;
}
