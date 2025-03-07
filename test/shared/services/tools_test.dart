import 'package:coinbase_cloud_advanced_trade_client/src/shared/services/tools.dart';
import 'package:test/test.dart';

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

  group('Test Generating Signature', () {
    setUp(() {});

    test('Test Generate Signature', () {
      final secret = 'mysecret';
      final method = 'GET';
      final path = '/v3/brokerage/products';
      final body = '';
      final signature = generateSignature(secret, method, path, body);

      expect(signature.signature.isNotEmpty, true);
      expect(signature.timestamp.isNotEmpty, true);
      expect(signature.messageToSign.isNotEmpty, true);
    });
  });
}
