import 'package:flutter/material.dart';
import 'package:mixkage_sber_code/common/theme/color_palette.dart';

/// Описывает основную цветовую схему приложения
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  /// Основной цвет, используется для кнопок, свитчей, заголовков, иконок и т.д.
  final Color primary;

  /// Цвет, для отрисовки текста на [primary].
  final Color onPrimary;

  /// Второй основной цвет, используется для разнообразия цветов.
  final Color secondary;

  /// Цвет, для отрисовки текста на [secondary].
  final Color onSecondary;

  /// Цвет, который используется для заднего фона.
  final Color surface;

  /// Второй цвет, который используется для заднего фона.
  final Color surfaceSecondary;

  /// Цвет, для отрисовки текста на [surface] и [surfaceSecondary].
  final Color onSurface;

  /// Цвет, который используется для ошибок, критических изменений и подобного.
  final Color danger;

  /// Цвет, для отрисовки текста на [danger].
  final Color onDanger;

  /// Цвет, который используется для информирования о успехе и подобного.
  final Color positive;

  /// Цвет, для отрисовки текста на [positive].
  final Color onPositive;

  /// Цвет, который используется для отрисовки неактивных элементов.
  final Color inactive;

  /// Цвет, который используется для эффектов загрузки.
  final Color shimmer;

  /// Конструктор для светлой темы
  AppColorScheme.light()
      : primary = LightColorPalette.blue,
        onPrimary = LightColorPalette.white,
        secondary = LightColorPalette.green,
        onSecondary = LightColorPalette.white,
        surface = LightColorPalette.darkWhite,
        surfaceSecondary = LightColorPalette.white,
        onSurface = LightColorPalette.black,
        danger = LightColorPalette.red,
        onDanger = LightColorPalette.white,
        inactive = LightColorPalette.grey,
        positive = LightColorPalette.green,
        onPositive = LightColorPalette.white,
        shimmer = LightColorPalette.grey;

  /// Консруктор для темной темы
  AppColorScheme.dark()
      : primary = DarkColorPalette.blue,
        onPrimary = DarkColorPalette.black,
        secondary = DarkColorPalette.green,
        onSecondary = DarkColorPalette.white,
        surface = DarkColorPalette.darkBlack,
        surfaceSecondary = DarkColorPalette.lightBlack,
        onSurface = DarkColorPalette.white,
        danger = DarkColorPalette.red,
        onDanger = DarkColorPalette.white,
        inactive = DarkColorPalette.grey,
        positive = DarkColorPalette.green,
        onPositive = DarkColorPalette.white,
        shimmer = DarkColorPalette.grey;

  // ignore: unused_element
  const AppColorScheme._({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.surfaceSecondary,
    required this.onSurface,
    required this.danger,
    required this.onDanger,
    required this.positive,
    required this.onPositive,
    required this.inactive,
    required this.shimmer,
  });

  @override
  ThemeExtension<AppColorScheme> copyWith({
    final Color? primary,
    final Color? onPrimary,
    final Color? secondary,
    final Color? onSecondary,
    final Color? surface,
    final Color? surfaceSecondary,
    final Color? onSurface,
    final Color? danger,
    final Color? onDanger,
    final Color? positive,
    final Color? onPositive,
    final Color? inactive,
    final Color? shimmer,
  }) =>
      AppColorScheme._(
        primary: primary ?? this.primary,
        onPrimary: onPrimary ?? this.onPrimary,
        secondary: secondary ?? this.secondary,
        onSecondary: onSecondary ?? this.onSecondary,
        surface: surface ?? this.surface,
        surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
        onSurface: onSurface ?? this.onSurface,
        danger: danger ?? this.danger,
        onDanger: onDanger ?? this.onDanger,
        positive: positive ?? this.positive,
        onPositive: onPositive ?? this.onPositive,
        inactive: inactive ?? this.inactive,
        shimmer: shimmer ?? this.shimmer,
      );

  @override
  ThemeExtension<AppColorScheme> lerp(
    covariant final ThemeExtension<AppColorScheme>? other,
    final double t,
  ) {
    if (other is! AppColorScheme) {
      return this;
    }

    return AppColorScheme._(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSecondary:
          Color.lerp(surfaceSecondary, other.surfaceSecondary, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      onPositive: Color.lerp(onPositive, other.onPositive, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
      shimmer: Color.lerp(shimmer, other.shimmer, t)!,
    );
  }

  /// Позволяет получить [AppColorScheme] из [BuildContext]
  static AppColorScheme of(final BuildContext context) =>
      Theme.of(context).extension<AppColorScheme>()!;
}
