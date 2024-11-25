import 'package:flutter/material.dart';
import 'package:mixkage_sber_code/common/theme/text_style.dart';

/// Описывает основную текстовую тему приложения
class AppTextScheme extends ThemeExtension<AppTextScheme> {
  /// Стиль текста с размером шрифта 45/52.
  ///
  /// Используется для корокой, важной информации или чисел.
  final TextStyle settingsLabel;

  /// Стиль текста с размером шрифта 45/52.
  ///
  /// Используется для корокой, важной информации или чисел.
  final TextStyle headline;

  /// Стиль текста с размером шрифта 28/36
  ///
  /// Используется для выделения основного контента в тексте.
  final TextStyle text;

  /// Стиль текста с размером шрифта 12/16
  ///
  /// Используется для выделения текста внутри компонетов. Например, кнопок.
  final TextStyle label;

  const AppTextScheme._({
    required this.settingsLabel,
    required this.headline,
    required this.text,
    required this.label,
  });

  /// Основной текстовой стиль
  AppTextScheme.base()
      : settingsLabel = CustomTextStyle.baseSettingsLabel.value,
        headline = CustomTextStyle.baseHeadline.value,
        text = CustomTextStyle.baseText.value,
        label = CustomTextStyle.baseLabel.value;

  @override
  ThemeExtension<AppTextScheme> copyWith({
    final TextStyle? settingsLabel,
    final TextStyle? headline,
    final TextStyle? text,
    final TextStyle? label,
  }) =>
      AppTextScheme._(
        settingsLabel: settingsLabel ?? this.settingsLabel,
        headline: headline ?? this.headline,
        text: text ?? this.text,
        label: label ?? this.label,
      );

  @override
  ThemeExtension<AppTextScheme> lerp(
    covariant final ThemeExtension<AppTextScheme>? other,
    final double t,
  ) {
    if (other is! AppTextScheme) {
      return this;
    }

    return AppTextScheme._(
      settingsLabel: TextStyle.lerp(settingsLabel, other.settingsLabel, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      text: TextStyle.lerp(text, other.text, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
    );
  }

  /// Позволяет получить [AppTextScheme] из [BuildContext]
  static AppTextScheme of(final BuildContext context) =>
      Theme.of(context).extension<AppTextScheme>() ??
      _throwThemeExceptionFromFunc(context);
}

/// Отлавливает ошибку, если текстовая тема не найдена в контексте
Never _throwThemeExceptionFromFunc(final BuildContext context) =>
    throw Exception('$AppTextScheme not found in $context');
