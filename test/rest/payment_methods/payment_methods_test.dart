import 'package:coinbase_cloud_advanced_trade_client/src/models/payment_method.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/payment_methods.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../tools.dart';

void main() {
  group('Test Payment Methods using MockClient', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Get a list of payment methods', () async {
      final String mockResponse =
          await getJsonFromFile('rest/payment_methods/list_payment_methods.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      List<PaymentMethod> paymentMethods = await getPaymentMethods(
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(paymentMethods.length, 1);
      expect(paymentMethods[0].id, "8bfc20d7-f7c6-4422-bf07-8243ca4169fe");
      expect(paymentMethods[0].type, "ACH");
      expect(paymentMethods[0].currency, "USD");
      expect(paymentMethods[0].verified, true);
    });

    test('Get a single payment method', () async {
      final String mockResponse =
          await getJsonFromFile('rest/payment_methods/get_payment_method.json');

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      PaymentMethod paymentMethod = await getPaymentMethod(
          paymentMethodId: "8bfc20d7-f7c6-4422-bf07-8243ca4169fe",
          client: mockClient,
          credential: constants.credentials,
          isSandbox: false);

      expect(paymentMethod, isNotNull);
      expect(paymentMethod.id, "8bfc20d7-f7c6-4422-bf07-8243ca4169fe");
      expect(paymentMethod.type, "ACH");
      expect(paymentMethod.currency, "USD");
      expect(paymentMethod.verified, true);
    });
  });

  group('Test Payment Methods Requests to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    test('Authorized Get Payment Methods', () async {
      List<PaymentMethod> paymentMethods = await getPaymentMethods(
          credential: constants.credentials, isSandbox: false);
      expect(paymentMethods, isNotNull);
    });

    test('Authorized Get Payment Method', () async {
      List<PaymentMethod> paymentMethods = await getPaymentMethods(
          credential: constants.credentials, isSandbox: false);

      if (paymentMethods.isNotEmpty) {
        String? paymentMethodId = paymentMethods.first.id;
        PaymentMethod paymentMethod = await getPaymentMethod(
            paymentMethodId: paymentMethodId!,
            credential: constants.credentials,
            isSandbox: false);
        expect(paymentMethod.id, paymentMethodId);
      }
    });
  });
}
