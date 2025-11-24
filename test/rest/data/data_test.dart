import 'dart:convert';
import 'dart:io';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/data.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../test_constants.dart' as constants;
import '../../test_helpers.dart';
import '../../tools.dart';

@GenerateMocks([http.Client])
void main() {
  final Logger logger = setupLogger('data_test');

  group('Data API REST Tests using Mocks', () {
    test('Get API Key Permissions', () async {
      final client = MockClient();
      final String getAPIKeyPermissionsJson =
          await getJsonFromFile('rest/data/get_api_key_permissions.json');

      when(client.send(any)).thenAnswer((_) async => http.StreamedResponse(
          Stream.value(utf8.encode(getAPIKeyPermissionsJson)), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      final result = await getKeyPermissions(
          client: client, credential: constants.credentials);

      expect(result, isNotNull);
      expect(result!.canView, isNotNull);
    });
  });

  group('Data API REST Tests Coinbase Requests to Coinbase AT API Endpoints',
      skip: constants.ciSkip, () {
    test('Get API Key Permissions', () async {
      final result = await getKeyPermissions(credential: constants.credentials);

      logger.info('Key Permissions: $result');

      expect(result, isNotNull);
      expect(result!.canView, isNotNull);
    });
  });
}
