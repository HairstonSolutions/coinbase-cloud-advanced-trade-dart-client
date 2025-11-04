import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/products.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_constants.dart';
import '../tools.dart';
import 'products_test.mocks.dart';

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);

@GenerateMocks([http.Client])
void main() {
  group('Products REST Tests', () {
    test('Get Best Bid Ask', () async {
      final client = MockClient();
      final String getBestBidAskJson =
          await getJsonFromFile('test/rest/products/get_best_bid_ask.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(getBestBidAskJson, 200));

      final result = await getBestBidAsk(
          client: client, credential: credentials, productIds: ['BTC-USD']);

      expect(result, isNotNull);
      expect(result!.pricebooks, isNotNull);
      expect(result.pricebooks!.isNotEmpty, isTrue);
    });
  });
}
