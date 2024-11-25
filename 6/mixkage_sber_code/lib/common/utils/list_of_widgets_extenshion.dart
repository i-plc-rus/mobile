import 'package:flutter/material.dart';

extension ListSpacing on List<Widget> {
  /// Создает новый список виджетов с отступами между элементами.
  List<Widget> withSpacing(final double spacing) {
    // Создаем список виджетов с отступами
    final widgetsWithSpacing = <Widget>[];
    for (int i = 0; i < length; i++) {
      widgetsWithSpacing.add(this[i]);
      if (i < length - 1) {
        widgetsWithSpacing.add(SizedBox(height: spacing));
      }
    }
    return widgetsWithSpacing;
  }
}
