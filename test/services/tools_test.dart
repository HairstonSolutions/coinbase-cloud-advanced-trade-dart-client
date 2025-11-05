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

  group('nullableNumber', () {
    test('should return a number when the value is a valid number string', () {
      final jsonObject = {'key': '123.45'};
      expect(nullableNumber(jsonObject, 'key'), 123.45);
    });

    test('should return null when the value is null', () {
      final jsonObject = {'key': null};
      expect(nullableNumber(jsonObject, 'key'), isNull);
    });

    test('should return null when the value is an empty string', () {
      final jsonObject = {'key': ''};
      expect(nullableNumber(jsonObject, 'key'), isNull);
    });

    test('should return 0.0 when notNullable is true and value is null', () {
      final jsonObject = {'key': null};
      expect(nullableNumber(jsonObject, 'key', notNullable: true), 0.0);
    });

    test(
        'should return a number when notNullable is true and value is a valid number string',
        () {
      final jsonObject = {'key': '678.90'};
      expect(nullableNumber(jsonObject, 'key', notNullable: true), 678.90);
    });
  });

  group('nullableDouble', () {
    test('should return a double when the value is a valid double string', () {
      final jsonObject = {'key': '123.45'};
      expect(nullableDouble(jsonObject, 'key'), 123.45);
    });

    test('should return null when the value is null', () {
      final jsonObject = {'key': null};
      expect(nullableDouble(jsonObject, 'key'), isNull);
    });

    test('should return null when the value is an empty string', () {
      final jsonObject = {'key': ''};
      expect(nullableDouble(jsonObject, 'key'), isNull);
    });

    test('should return 0.0 when notNullable is true and value is null', () {
      final jsonObject = {'key': null};
      expect(nullableDouble(jsonObject, 'key', notNullable: true), 0.0);
    });

    test(
        'should return a double when notNullable is true and value is a valid double string',
        () {
      final jsonObject = {'key': '678.90'};
      expect(nullableDouble(jsonObject, 'key', notNullable: true), 678.90);
    });
  });
}
