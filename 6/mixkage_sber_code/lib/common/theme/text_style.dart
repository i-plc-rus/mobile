import 'package:flutter/material.dart';

const _double42 = 36.0;

/// Размер шрифта 22
const _double22 = 22.0;

/// Размер шрифта 16
const _double16 = 16.0;

/// Размер шрифта 14
const _double14 = 14.0;

/// Кастомные стили шрифтов для приложения
enum CustomTextStyle {
  baseSettingsLabel(
    TextStyle(
      // fontFamily: 'Inter',
      fontSize: _double42,
      fontWeight: FontWeight.w200,
      height: 1.2,
    ),
  ),
  baseHeadline(
    TextStyle(
      // fontFamily: 'Inter',
      fontSize: _double22,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
  ),
  baseText(
    TextStyle(
      // fontFamily: 'Inter',
      fontSize: _double16,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
  ),
  baseLabel(
    TextStyle(
      // fontFamily: 'PlusJakartaSans',
      fontSize: _double14,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
  );

  final TextStyle value;

  const CustomTextStyle(this.value);
}
