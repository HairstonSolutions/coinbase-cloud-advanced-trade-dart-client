double? nullableDouble(var jsonObject, String key,
    {bool? notNullable = false}) {
  if (notNullable == true) {
    return (jsonObject[key] == null) ? 0.0 : double.parse(jsonObject[key]);
  }
  if (jsonObject[key] == "") {
    return null;
  }
  return (jsonObject[key] == null) ? null : double.parse(jsonObject[key]);
}

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
