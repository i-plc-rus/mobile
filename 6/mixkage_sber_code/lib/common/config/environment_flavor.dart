import 'package:flutter/foundation.dart';

/// Перечисление всех поддерживаемых в приложении Flavor's
enum EnvironmentFlavor {
  production,
  debug,
  profile;

  /// Проверяет запущено ли приложение в production режиме
  bool get isProduction => this == production;

  /// Проверяет запущено ли приложение в debug режиме
  bool get isDebug => this == debug;

  /// Проверяет запущено ли приложение в profile режиме
  bool get isProfile => this == profile;

  /// Преобразует строку в enum-значение
  static EnvironmentFlavor fromString(final String value) {
    switch (value) {
      case 'PRODUCTION':
        return production;
      case 'DEVELOPMENT':
        return debug;
      case 'PROFILE':
        return profile;
      case _:
        return kReleaseMode ? production : debug;
    }
  }
}
