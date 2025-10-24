import 'package:logger/logger.dart';

class Log {

  static final Logger _logger = Logger(
      printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          // dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart
      )
  );

  static void trace (String s) {
    _logger.t(s);
  }

  static void debug (String s) {
    _logger.d(s);
  }

  static void info (String s) {
    _logger.i(s);
  }

  static void warn (String s) {
    _logger.w(s);
  }

  static void error (String s) {
    _logger.e(s);
  }

  static void fail (String s) {
    _logger.f(s);
  }
}