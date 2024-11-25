/// Перечисление всех возможных маршрутов
enum Routes {
  home,
  error,
  settings,
}

/// Описывает пути для всех возможных маршрутов
extension RoutesExtension on Routes {
  String get toPath {
    switch (this) {
      case Routes.home:
        return '/home';
      case Routes.error:
        return '/error';
      case Routes.settings:
        return '/settings';
    }
  }

  /// Создает имя для всех возможных маршрутов
  String get toName {
    switch (this) {
      case Routes.home:
        return 'HOME';
      case Routes.error:
        return 'ERROR';
      case Routes.settings:
        return 'SETTINGS';
    }
  }
}
