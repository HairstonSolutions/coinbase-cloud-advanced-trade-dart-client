import 'package:coinbase_cloud_advanced_trade_client/src/rest/public/server_time.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.mocks.dart';
import '../../tools.dart';

@GenerateMocks([http.Client])
void main() {
  group('Public REST Tests using Mocks', () {
    test('Get Server Time', () async {
      final client = MockClient();
      final String productBookJson =
          await getJsonFromFile('rest/public/get_server_time.json');

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(productBookJson, 200));

      final serverTime = await getServerTime(client: client);

      expect(serverTime, isNotNull);
      expect(serverTime!.iso, isNotNull);
      expect(serverTime.epochSeconds, isNotNull);
      expect(serverTime.epochMillis, isNotNull);
    });
  });

  group('Public REST Tests Requests to Coinbase AT API Endpoints', () {
    test('Get Server Time', () async {
      final serverTime = await getServerTime();

      print('Server Time: $serverTime');

      expect(serverTime, isNotNull);
      expect(serverTime!.iso, isNotNull);
      expect(serverTime.epochSeconds, isNotNull);
      expect(serverTime.epochMillis, isNotNull);
    });
  });
}
