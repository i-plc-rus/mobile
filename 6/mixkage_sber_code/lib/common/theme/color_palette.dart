import 'package:flutter/widgets.dart';

/// Палитра цветов для светлой темы
abstract class LightColorPalette {
  static const white = Color.fromARGB(255, 241, 241, 241);

  static const darkWhite = Color.fromARGB(255, 225, 225, 225);

  static const black = Color(0xFF212325);

  static const grey = Color(0xFF6C7278);

  static const blue = Color(0xFF246BFD);

  static const red = Color(0xFFFF968E);

  static const green = Color(0xFF5DCD9B);
}

/// Палитра цветов для темной темы
abstract class DarkColorPalette {
  static const black = Color(0xFF212325);

  static const darkBlack = Color.fromARGB(255, 14, 15, 15);

  static const lightBlack = Color(0xFF3A3D46);

  static const white = Color(0xFFFFFFFF);

  static const grey = Color(0xFF6C7278);

  static const blue = Color.fromARGB(255, 10, 65, 174);

  static const red = Color(0xFFFF968E);

  static const green = Color.fromARGB(255, 62, 139, 66);
}
