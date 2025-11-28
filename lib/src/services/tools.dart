/// Parses a double from a JSON object, returning null if the value is null or an
/// empty string.
///
/// [jsonObject] - The JSON object to parse the double from.
/// [key] - The key of the double to parse.
/// [notNullable] - Whether to return 0.0 if the value is null.
///
/// Returns a double, or null if the value is null or an empty string.
double? nullableDouble(Map<String, dynamic> jsonObject, String key,
    {bool notNullable = false}) {
  final value = jsonObject[key];

  if (value == null || value == '') {
    return notNullable ? 0.0 : null;
  }

  final parsedValue = double.tryParse(value.toString());
  if (parsedValue == null && notNullable) {
    return 0.0;
  }

  return parsedValue;
}

/// Parses a number from a JSON object, returning null if the value is null or an
/// empty string.
///
/// [jsonObject] - The JSON object to parse the number from.
/// [key] - The key of the number to parse.
/// [notNullable] - Whether to return 0.0 if the value is null.
///
/// Returns a number, or null if the value is null or an empty string.
num? nullableNumber(Map<String, dynamic> jsonObject, String key,
    {bool? notNullable = false}) {
  if (notNullable == true) {
    return (jsonObject[key] == null) ? 0.0 : num.parse(jsonObject[key]);
  }
  if (jsonObject[key] == "") {
    return null;
  }
  return (jsonObject[key] == null)
      ? null
      : num.parse(jsonObject[key].toString());
}

/// Converts a map of query parameters to a string.
///
/// [queryParameters] - The map of query parameters to convert.
///
/// Returns a string representation of the query parameters.
String? convertParamsToString(Map<String, dynamic> queryParameters) {
  late String conversion;
  conversion = "";

  if (queryParameters.isNotEmpty) {
    conversion = "?";
    int count = 0;

    for (var entry in queryParameters.entries) {
      if (count > 0) {
        conversion = "$conversion&";
      }
      conversion = "$conversion${entry.key}=${entry.value}";
      count++;
    }
  }

  return conversion;
}
