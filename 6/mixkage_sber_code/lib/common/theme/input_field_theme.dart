import 'package:flutter/material.dart';

/// Тема для поля для ввода
abstract class InputFieldTheme {
  static final inputThemeLight = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.black12,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    filled: true,
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    fillColor: Colors.white60,
  );

  static final inputThemeDark = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.black12,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    filled: true,
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    fillColor: Colors.black45,
  );
}
