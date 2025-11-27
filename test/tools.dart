import 'dart:convert';
import 'dart:io' show File;

import 'package:logging/logging.dart';

import 'test_helpers.dart';

final Logger logger = setupLogger('tools');

/// Reads a JSON file from the test directory and returns its contents as a
/// string.
///
/// [filename] - The name of the file to read.
///
/// Returns the contents of the file as a string.
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
    logger.severe('Error: $e');
  }

  return exampleJson;
}
