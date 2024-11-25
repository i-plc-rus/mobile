import 'package:logger/logger.dart' as l;
import 'package:mixkage_sber_code/common/log/i_logger.dart';

final logger = Logger(l.Logger());

/// Реализация интерфейса [ILogger]
class Logger implements ILogger {
  final l.Logger logger;

  const Logger(this.logger);

  @override
  void d(
    final String message, {
    final DateTime? time,
    final StackTrace? stackTrace,
  }) {
    logger.d(message, time: time, stackTrace: stackTrace);
  }

  @override
  void i(
    final String message, {
    final DateTime? time,
    final StackTrace? stackTrace,
  }) {
    logger.i(message, time: time, stackTrace: stackTrace);
  }

  @override
  void w(
    final String message, {
    final DateTime? time,
    final StackTrace? stackTrace,
  }) {
    logger.w(message, time: time, stackTrace: stackTrace);
  }

  @override
  void e(
    final String message, {
    final DateTime? time,
    final StackTrace? stackTrace,
  }) {
    logger.e(message, time: time, stackTrace: stackTrace);
  }
}
