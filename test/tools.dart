import 'dart:convert';
import 'dart:io' show File;

Future<String> getJsonFromFile(String filename) async {
  String exampleJson = '';
  final file = File('test/$filename');
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  try {
    await for (var line in lines) {
      exampleJson += line;
    }
  } catch (e) {
    print('Error: $e');
  }

  return exampleJson;
}
