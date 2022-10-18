double? nullableDouble(var jsonObject, String key,
    {bool? notNullable = false}) {
  if (notNullable == true) {
    return (jsonObject[key] == null) ? 0.0 : double.parse(jsonObject[key]);
  }
  return (jsonObject[key] == null) ? null : double.parse(jsonObject[key]);
}
