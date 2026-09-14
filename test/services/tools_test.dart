import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';
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

  group('nullableDecimal', () {
    test('should return a Decimal when the value is a decimal string', () {
      final jsonObject = {'key': '123.45'};
      expect(nullableDecimal(jsonObject, 'key'), Decimal.parse('123.45'));
    });

    test('should keep precision a double would lose', () {
      final jsonObject = {'key': '61250.10'};
      expect(nullableDecimal(jsonObject, 'key'), Decimal.parse('61250.10'));
    });

    test('should parse a satoshi-scale increment exactly', () {
      final jsonObject = {'key': '0.00000001'};
      expect(nullableDecimal(jsonObject, 'key').toString(), '0.00000001');
    });

    test('should return null when the value is null', () {
      final jsonObject = {'key': null};
      expect(nullableDecimal(jsonObject, 'key'), isNull);
    });

    test('should return null when the value is an empty string', () {
      final jsonObject = {'key': ''};
      expect(nullableDecimal(jsonObject, 'key'), isNull);
    });

    test('should throw FormatException when the value is not a number', () {
      final jsonObject = {'key': 'not-a-number'};
      expect(() => nullableDecimal(jsonObject, 'key'), throwsFormatException);
    });

    test('should pass through a value that is already a Decimal', () {
      final jsonObject = {'key': Decimal.parse('7.5')};
      expect(nullableDecimal(jsonObject, 'key'), Decimal.parse('7.5'));
    });

    test('should throw FormatException for JSON number when allowNum is false',
        () {
      final jsonObject = {'key': 10000.0};
      expect(() => nullableDecimal(jsonObject, 'key'), throwsFormatException);
    });

    test('should accept a JSON number when allowNum is true', () {
      final jsonObject = {'key': 10000.0};
      expect(nullableDecimal(jsonObject, 'key', allowNum: true),
          Decimal.fromInt(10000));
    });

    test('should throw FormatException when invalid string is passed', () {
      final jsonObject = {'key': 'abc'};
      expect(() => nullableDecimal(jsonObject, 'key'), throwsFormatException);
    });
  });

  group('requiredDecimal', () {
    test('should return a Decimal when the value is a decimal string', () {
      final jsonObject = {'key': '678.90'};
      expect(requiredDecimal(jsonObject, 'key'), Decimal.parse('678.90'));
    });

    test('should throw FormatException when the value is missing', () {
      final jsonObject = <String, dynamic>{};
      expect(() => requiredDecimal(jsonObject, 'key'), throwsFormatException);
    });

    test('should throw FormatException when the value is empty', () {
      final jsonObject = {'key': ''};
      expect(() => requiredDecimal(jsonObject, 'key'), throwsFormatException);
    });

    test('should throw FormatException when the value is unparsable', () {
      final jsonObject = {'key': 'not-a-number'};
      expect(() => requiredDecimal(jsonObject, 'key'), throwsFormatException);
    });
  });

  group('nullableInt', () {
    test('should return an int when the value is an int string', () {
      final jsonObject = {'key': '2'};
      expect(nullableInt(jsonObject, 'key'), 2);
    });

    test('should return null when the value is null', () {
      final jsonObject = {'key': null};
      expect(nullableInt(jsonObject, 'key'), isNull);
    });

    test('should return null when the value is an empty string', () {
      final jsonObject = {'key': ''};
      expect(nullableInt(jsonObject, 'key'), isNull);
    });

    test('should truncate a decimal string to an int', () {
      final jsonObject = {'key': '2.0'};
      expect(nullableInt(jsonObject, 'key'), 2);
    });

    test('should return 0 when notNullable is true and value is null', () {
      final jsonObject = {'key': null};
      expect(nullableInt(jsonObject, 'key', notNullable: true), 0);
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

    test('should return 0 when notNullable is true and value is null', () {
      final jsonObject = {'key': null};
      expect(nullableNumber(jsonObject, 'key', notNullable: true), 0);
    });

    test('should keep a fractional epoch value', () {
      final jsonObject = {'key': '1715591792.118'};
      expect(nullableNumber(jsonObject, 'key'), 1715591792.118);
    });
  });
}
