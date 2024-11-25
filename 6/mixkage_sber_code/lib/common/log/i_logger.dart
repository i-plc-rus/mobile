/// Интерфейс, который описывает базовый функционал логгера
abstract interface class ILogger {
  /// Позволяет записывать информацию Debug-уровня
  void d(
    final String message, {
    final DateTime? time,
    final StackTrace? stackTrace,
  });

  /// Позволяет записывать информацию Info-уровень
  void i(
    final String message, {
    final DateTime? time,
    final StackTrace? stackTrace,
  });

  /// Позволяет записывать информацию Warning-уровня
  void w(
    final String message, {
    final DateTime? time,
    final StackTrace? stackTrace,
  });

  /// Позволяет записывать информацию Error-уровня
  void e(
    final String message, {
    final DateTime? time,
    final StackTrace? stackTrace,
  });
}
