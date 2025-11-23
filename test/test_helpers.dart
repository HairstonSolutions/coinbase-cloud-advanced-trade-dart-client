import 'package:logging/logging.dart';

/// Sets up the logger for tests.
///
/// [name] - The name of the logger.
/// [printLogs] - Whether to print logs to the console.
Logger setupLogger(String name, {bool printLogs = true}) {
  final Logger logger = Logger(name);
  Logger.root.level = Level.ALL;
  if (printLogs) {
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
  return logger;
}
