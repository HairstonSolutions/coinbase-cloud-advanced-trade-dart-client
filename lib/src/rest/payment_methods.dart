import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/payment_method.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of payment methods.
///
/// GET /api/v3/brokerage/payment_methods
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/payment-methods/list-payment-methods
///
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [PaymentMethod] objects.
Future<List<PaymentMethod>> listPaymentMethods(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/payment_methods',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var paymentMethods = <PaymentMethod>[];
    for (var paymentMethod in jsonResponse) {
      paymentMethods.add(PaymentMethod.fromCBJson(paymentMethod));
    }
    return paymentMethods;
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
    return [];
  }
}

/// Gets a payment method.
///
/// GET /api/v3/brokerage/payment_methods/{payment_method_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/payment-methods/get-payment-method
///
/// [paymentMethodId] - The ID of the payment method to get.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PaymentMethod] object.
Future<PaymentMethod?> getPaymentMethod(
    {required String paymentMethodId,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized(
      '/payment_methods/$paymentMethodId',
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return PaymentMethod.fromCBJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed: Response code ${response.statusCode}');
    print('Error Response Message: ${response.body}');
  }
  return null;
}
