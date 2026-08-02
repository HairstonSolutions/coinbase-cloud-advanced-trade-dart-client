import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

import '../../test_constants.dart' as constants;
import '../../tools.dart';

void main() {
  group('Payment Methods REST', () {
    test('getPaymentMethod returns a single payment method', () async {
      String jsonResponse =
          await getJsonFromFile('rest/payment_methods/get_payment_method.json');

      final client = MockClient((request) async {
        return http.Response(jsonResponse, 200);
      });

      Credential credential = Credential(
          apiKeyName: 'testApiKey', privateKeyPEM: constants.privateKeyPEM);

      PaymentMethod paymentMethod = await getPaymentMethod(
          paymentMethodId: '8bfc20d7-f7c6-4422-bf07-8243ca4169fe',
          client: client,
          credential: credential);

      expect(paymentMethod.id, '8bfc20d7-f7c6-4422-bf07-8243ca4169fe');
      expect(paymentMethod.type, 'ACH');
      expect(paymentMethod.name, 'ALLY BANK ******1234');
      expect(paymentMethod.currency, 'USD');
      expect(paymentMethod.verified, true);
      expect(paymentMethod.allowBuy, true);
      expect(paymentMethod.allowSell, true);
      expect(paymentMethod.allowDeposit, true);
      expect(paymentMethod.allowWithdraw, true);
      expect(paymentMethod.createdAt?.toIso8601String(),
          DateTime.parse('2021-05-31T09:59:59Z').toIso8601String());
      expect(paymentMethod.updatedAt?.toIso8601String(),
          DateTime.parse('2021-05-31T09:59:59Z').toIso8601String());
    });
  });
}
