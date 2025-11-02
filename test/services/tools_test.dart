import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
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
}
