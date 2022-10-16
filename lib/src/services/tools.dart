double nullableDouble(var jsonObject, String key) {
  return (jsonObject[key] == null) ? 0.0 : double.parse(jsonObject[key]);
}
