// ignore_for_file: do_not_use_environment

import 'package:mixkage_sber_code/common/config/environment_flavor.dart';

/// Глобальный конфиг приложения
abstract final class Config {
  const Config();

  /// Ссылка для взаимодействия с API
  static const String apiUri = String.fromEnvironment(
    'API_URI',
    defaultValue: 'http://localhost:3000/',
  );

  /// DSN для интеграции с Sentry
  static const String sentryDsn = String.fromEnvironment('SENTRY_DSN');

  /// Флаг для получения моковые ли данные
  static const bool isMockData =
      String.fromEnvironment('DATA_SOURCE', defaultValue: 'SERVER') == 'MOCK';

  /// Режим сборки приложения
  static final EnvironmentFlavor environmentFlavor =
      EnvironmentFlavor.fromString(
    const String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'DEVELOPMENT',
    ),
  );
}
