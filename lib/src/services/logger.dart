import 'package:logging/logging.dart';

/// Sets up the logger for the application.
///
/// [name] - The name of the logger.
Logger setupLogger(String name) {
  final Logger logger = Logger(name);
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  return logger;
}
