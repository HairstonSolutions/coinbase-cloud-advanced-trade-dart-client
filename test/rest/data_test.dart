import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/data.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_constants.dart';
import '../tools.dart';
import 'data_test.mocks.dart';

final Credential credentials =
    Credential(apiKeyName: apiKeyName, privateKeyPEM: privateKeyPEM);

@GenerateMocks([http.Client])
void main() {
  group('Data API REST Tests', () {
    test('Get API Key Permissions', () async {
      final client = MockClient();
      final String getAPIKeyPermissionsJson =
          await getJsonFromFile('test/rest/data/get_api_key_permissions.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(getAPIKeyPermissionsJson, 200));

      final result =
          await getKeyPermissions(client: client, credential: credentials);

      expect(result, isNotNull);
      expect(result!.canView, isNotNull);
    });
  });
}
