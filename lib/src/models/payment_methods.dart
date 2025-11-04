import 'package:coinbase_cloud_advanced_trade_client/src/models/payment_method.dart';

class PaymentMethods {
  final List<PaymentMethod> paymentMethods;

  PaymentMethods({required this.paymentMethods});

  factory PaymentMethods.fromCBJson(Map<String, dynamic> json) {
    var paymentMethods = <PaymentMethod>[];
    for (var paymentMethod in json['payment_methods']) {
      paymentMethods.add(PaymentMethod.fromCBJson(paymentMethod));
    }

    return PaymentMethods(paymentMethods: paymentMethods);
  }
}
