import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/payment_method.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a list of payment methods for the current user.
///
/// GET /api/v3/brokerage/payment_methods
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/payment-methods/list-payment-methods
///
/// [client] - Optional http client.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a list of [PaymentMethod] objects.
Future<List<PaymentMethod>> getPaymentMethods(
    {http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  List<PaymentMethod> paymentMethods = [];

  http.Response response = await getAuthorized('/payment_methods',
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    final jsonList = jsonResponse['payment_methods'] as List<dynamic>?;
    if (jsonList == null) {
      throw Exception('payment_methods key is missing or null');
    }
    paymentMethods = jsonList.map((item) => PaymentMethod.fromCBJson(item)).toList();
  } else {
    throw CoinbaseException(
        'Failed to get payment methods', response.statusCode, response.body);
  }

  return paymentMethods;
}

/// Gets a single payment method for the current user by ID.
///
/// GET /api/v3/brokerage/payment_methods/{payment_method_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/payment-methods/get-payment-method
///
/// [paymentMethodId] - The ID of the payment method to be returned.
/// [client] - Optional http client.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PaymentMethod] object.
Future<PaymentMethod> getPaymentMethod(
    {required String paymentMethodId,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  http.Response response = await getAuthorized('/payment_methods/$paymentMethodId',
      client: client, credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    final jsonPaymentMethod = jsonResponse['payment_method'];
    if (jsonPaymentMethod == null) {
      throw CoinbaseException('Payment method data missing', response.statusCode, response.body);
    }
    return PaymentMethod.fromCBJson(jsonPaymentMethod);
  } else {
    throw CoinbaseException(
        'Failed to get payment method', response.statusCode, response.body);
  }
}
