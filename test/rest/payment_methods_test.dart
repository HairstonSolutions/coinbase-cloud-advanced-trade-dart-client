import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/payment_methods.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_constants.dart';
import '../tools.dart';
import 'payment_methods_test.mocks.dart';

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);

@GenerateMocks([http.Client])
void main() {
  group('Payment Methods REST Tests', () {
    test('List Payment Methods', () async {
      final client = MockClient();
      final String listPaymentMethodsJson = await getJsonFromFile(
          'test/rest/payment_methods/list_payment_methods.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(listPaymentMethodsJson, 200));

      final result =
          await listPaymentMethods(client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result.isNotEmpty, isTrue);
    });

    test('Get Payment Method', () async {
      final client = MockClient();
      final String getPaymentMethodJson = await getJsonFromFile(
          'test/rest/payment_methods/get_payment_method.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(getPaymentMethodJson, 200));

      final result = await getPaymentMethod(
          client: client, credential: credentials, paymentMethodId: '1234');

      expect(result, isNotNull);
      expect(result!.id, isNotNull);
    });
  });
}
