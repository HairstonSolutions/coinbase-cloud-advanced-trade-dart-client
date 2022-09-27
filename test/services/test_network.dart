import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? checkEnvSandbox = envVars['COINBASE_SANDBOX'];
bool isSbx = checkEnvSandbox == 'true' ? true : false;

void main() {
  group('Test Requests to Coinbase API Endpoints', () {
    setUp(() {});

    test('Get Products from Production', () async {
      var response = await get('/products');
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Get Products from Sandbox & Print', () async {
      var response = await get('/products', isSandbox: true);

      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');

      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
      }

      expect(response.statusCode == 200, isTrue);
    });

    test('Requesting broken endpoint gives non 200 Response Code', () async {
      var response = await get('/fake', isSandbox: isSbx);

      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');

      expect(response.statusCode != 200, isTrue);
    });
  });
}
