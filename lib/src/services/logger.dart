import 'package:logging/logging.dart';

bool _loggerInitialized = false;

/// Sets up the logger for the application.
///
/// [name] - The name of the logger.
Logger setupLogger(String name) {
  if (!_loggerInitialized) {
    _loggerInitialized = true;
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
  return Logger(name);
}
