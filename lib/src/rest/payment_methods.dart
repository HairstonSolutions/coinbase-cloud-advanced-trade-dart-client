import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/payment_method.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets a single payment method for the current user.
///
/// GET /api/v3/brokerage/payment_methods/{payment_method_id}
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/payment-methods/get-payment-method
///
/// This function makes a GET request to the /payment_methods/{payment_method_id} endpoint of the
/// Coinbase Advanced Trade API.
///
/// [paymentMethodId] - The ID of the payment method to be returned.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [PaymentMethod] object.
Future<PaymentMethod> getPaymentMethod(
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
    var jsonPaymentMethod = jsonResponse['payment_method'];

    return PaymentMethod.fromCBJson(jsonPaymentMethod);
  } else {
    throw CoinbaseException(
        'Failed to get payment method', response.statusCode, response.body);
  }
}
