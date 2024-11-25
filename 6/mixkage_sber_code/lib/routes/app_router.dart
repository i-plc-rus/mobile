import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mixkage_sber_code/common/screens/error_screen.dart';
import 'package:mixkage_sber_code/feature/home_screen/screens/home_screen.dart';
import 'package:mixkage_sber_code/feature/settings_screen/screens/settings_screen.dart';
import 'package:mixkage_sber_code/routes/routes.dart';

/// Настроенный роутер для всего приложения
abstract class AppRouter {
  const AppRouter();

  /// Экземпляр настроенного роутера
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.home.toPath,
    routes: [
      GoRoute(
        path: '/',
        redirect: (final context, final state) => Routes.home.toPath,
      ),
      GoRoute(
        path: Routes.home.toPath,
        name: Routes.home.toName,
        builder: (final context, final state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.settings.toPath,
        name: Routes.settings.toName,
        builder: (final context, final state) => const SettingsScreen(),
      ),
    ],
    errorPageBuilder: (final context, final state) => const MaterialPage(
      child: ErrorScreen(),
    ),
  );
}
