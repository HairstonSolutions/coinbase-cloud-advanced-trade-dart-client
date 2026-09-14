import 'package:decimal/decimal.dart';

/// Parses a [Decimal] from a JSON object, returning null if the value is null
/// or an empty string.
///
/// Coinbase sends monetary and quantity fields as decimal strings. Parsing them
/// into a [Decimal] keeps the value exact; parsing them into a `double` would
/// lose precision before the caller ever sees it.
///
/// [jsonObject] - The JSON object to parse the decimal from.
/// [key] - The key of the decimal to parse.
/// [notNullable] - Whether to return [Decimal.zero] if the value is null,
/// empty or unparsable.
///
/// Returns a [Decimal], or null if the value is null, empty or unparsable.
Decimal? nullableDecimal(Map<String, dynamic> jsonObject, String key,
    {bool notNullable = false}) {
  final value = jsonObject[key];

  if (value == null || value == '') {
    return notNullable ? Decimal.zero : null;
  }

  if (value is Decimal) {
    return value;
  }

  final parsedValue = Decimal.tryParse(value.toString());
  if (parsedValue == null && notNullable) {
    return Decimal.zero;
  }

  return parsedValue;
}

/// Parses a required [Decimal] from a JSON object.
///
/// Used for fields the Coinbase API always sends. Falls back to [Decimal.zero]
/// when the value is missing, empty or unparsable.
///
/// [jsonObject] - The JSON object to parse the decimal from.
/// [key] - The key of the decimal to parse.
///
/// Returns a [Decimal], never null.
Decimal requiredDecimal(Map<String, dynamic> jsonObject, String key) =>
    nullableDecimal(jsonObject, key, notNullable: true)!;

/// Parses an int from a JSON object, returning null if the value is null or an
/// empty string.
///
/// Used for genuinely integral fields such as counts.
///
/// [jsonObject] - The JSON object to parse the int from.
/// [key] - The key of the int to parse.
/// [notNullable] - Whether to return 0 if the value is null.
///
/// Returns an int, or null if the value is null or an empty string.
int? nullableInt(Map<String, dynamic> jsonObject, String key,
    {bool notNullable = false}) {
  final value = jsonObject[key];

  if (value == null || value == '') {
    return notNullable ? 0 : null;
  }

  if (value is int) {
    return value;
  }

  final parsedValue = int.tryParse(value.toString()) ??
      double.tryParse(value.toString())?.toInt();
  if (parsedValue == null && notNullable) {
    return 0;
  }

  return parsedValue;
}

/// Parses a number from a JSON object, returning null if the value is null or
/// an empty string.
///
/// This is for non-monetary numeric fields such as epoch timestamps. Monetary
/// and quantity fields must use [nullableDecimal] instead, so that decimal
/// precision is never lost to binary floating point.
///
/// [jsonObject] - The JSON object to parse the number from.
/// [key] - The key of the number to parse.
/// [notNullable] - Whether to return 0 if the value is null.
///
/// Returns a number, or null if the value is null or an empty string.
num? nullableNumber(Map<String, dynamic> jsonObject, String key,
    {bool notNullable = false}) {
  final value = jsonObject[key];

  if (value == null || value == '') {
    return notNullable ? 0 : null;
  }

  if (value is num) {
    return value;
  }

  final parsedValue = num.tryParse(value.toString());
  if (parsedValue == null && notNullable) {
    return 0;
  }

  return parsedValue;
}

/// Converts a map of query parameters to a string.
///
/// [queryParameters] - The map of query parameters to convert.
///
/// Returns a string representation of the query parameters.
String? convertParamsToString(Map<String, dynamic> queryParameters) {
  if (queryParameters.isEmpty) {
    return "";
  }

  return "?${queryParameters.entries.map((entry) => '${entry.key}=${entry.value}').join('&')}";
}
