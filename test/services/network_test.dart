import 'dart:io' show Platform;

import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
import 'package:test/test.dart';

Map<String, String> envVars = Platform.environment;
String? checkEnvSandbox = envVars['COINBASE_SANDBOX'];
String? cbAccessKey = envVars['COINBASE_ACCESS_KEY'];
String? cbSecret = envVars['COINBASE_SECRET'];
String? cbPassphrase = envVars['COINBASE_PASSPHRASE'];
bool isSbx = checkEnvSandbox == 'true' ? true : false;
String? skipTests = envVars['SKIP_TESTS'];
bool skip = skipTests == 'false' ? false : true;
Credential credentials = Credential(cbAccessKey!, cbSecret!, cbPassphrase!);

void main() {
  group('Test Converting Parameters', () {
    setUp(() {});

    test('Test Convert Parameters to String', () {
      Map<String, dynamic>? queryParameters = {
        "profile_id": "default",
        "limit": "100",
        "product_id": "BTC-USD"
      };

      expect(convertParamsToString(queryParameters),
          "?profile_id=default&limit=100&product_id=BTC-USD");
    });

    test('Test Convert Empty Parameters to String', () {
      Map<String, dynamic>? queryParameters = {};

      expect(convertParamsToString(queryParameters), "");
    });
  });

  group('Test Authorized Requests to Coinbase API Endpoints', skip: skip, () {
    setUp(() {});

    test('Authorized Get with no body (Fees)', () async {
      String requestPath = "/fees";
      var response = await getAuthorized(requestPath,
          credential: credentials, isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized Get with body (Fills)', () async {
      String requestPath = "/fills";
      Map<String, dynamic>? queryParameters = {
        "profile_id": "default",
        "limit": "100",
        "product_id": "BTC-USD"
      };

      var response = await getAuthorized(requestPath,
          queryParameters: queryParameters,
          credential: credentials,
          isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized POST with body (order)', skip: true, () async {
      String requestPath = "/orders";
      Map<String, dynamic>? body = {
        'profile_id': 'default',
        'side': 'buy',
        'product_id': 'BTC-USD',
        'type': 'limit',
        'time_in_force': 'GTC',
        'size': 1,
        'price': 200.00
      };

      var response = await postAuthorized(requestPath,
          body: body, credential: credentials, isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print(response.body);

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized Delete with query Params (an order)', skip: true,
        () async {
      String requestPath = "/orders";
      String orderId = "aa221d31-bbc6-4563-9005-211448ddf47c";
      Map<String, dynamic>? queryParameters = {
        'profile_id': 'default',
        'product_id': 'BTC-USD'
      };

      var response = await deleteAuthorized('$requestPath/$orderId',
          queryParameters: queryParameters,
          credential: credentials,
          isSandbox: true);
      var url = response.request?.url.toString();
      print('Response Code: ${response.statusCode} to URL: $url');
      print('Response Body: ${response.body}');

      expect(response.statusCode == 200, isTrue);
    });
  });

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
