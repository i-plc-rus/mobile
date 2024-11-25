import 'package:flutter/material.dart';
import 'package:mixkage_sber_code/common/theme/app_color_scheme.dart';
import 'package:mixkage_sber_code/common/theme/app_text_scheme.dart';
import 'package:mixkage_sber_code/common/theme/input_field_theme.dart';

/// Настроенная тема для приложения
abstract class AppThemeData {
  static final _lightColorScheme = AppColorScheme.light();
  static final _darkColorScheme = AppColorScheme.dark();
  static final _textScheme = AppTextScheme.base();

  /// Настроенная светлая тема для приложения
  static final lightTheme = ThemeData(
    extensions: [_lightColorScheme, _textScheme],
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: _lightColorScheme.primary,
      onPrimary: _lightColorScheme.onPrimary,
      secondary: _lightColorScheme.secondary,
      onSecondary: _lightColorScheme.onSecondary,
      error: _lightColorScheme.danger,
      onError: _lightColorScheme.onDanger,
      surface: _lightColorScheme.surface,
      onSurface: _lightColorScheme.onSurface,
    ),
    scaffoldBackgroundColor: _lightColorScheme.surface,
    listTileTheme: ListTileThemeData(
      tileColor: _lightColorScheme.surface,
    ),
    inputDecorationTheme: InputFieldTheme.inputThemeLight,
  );

  /// Настроенная темная тема для приложения
  static final darkTheme = ThemeData(
    extensions: [_darkColorScheme, _textScheme],
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: _darkColorScheme.primary,
      onPrimary: _darkColorScheme.onPrimary,
      secondary: _darkColorScheme.secondary,
      onSecondary: _darkColorScheme.onSecondary,
      error: _darkColorScheme.danger,
      onError: _darkColorScheme.onDanger,
      surface: _darkColorScheme.surface,
      onSurface: _darkColorScheme.onSurface,
    ),
    scaffoldBackgroundColor: _lightColorScheme.surface,
    listTileTheme: ListTileThemeData(
      tileColor: _darkColorScheme.surface,
    ),
    inputDecorationTheme: InputFieldTheme.inputThemeDark,
  );
}
