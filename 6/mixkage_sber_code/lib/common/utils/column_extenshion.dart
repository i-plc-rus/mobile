import 'package:flutter/material.dart';

extension ColumnSpacing on Column {
  /// Создает новый [Column] с отступами между дочерними виджетами.
  Column withSpacing(final double spacing) {
    // Создаем список виджетов с отступами
    final childrenWithSpacing = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      childrenWithSpacing.add(children[i]);
      if (i < children.length - 1) {
        childrenWithSpacing.add(SizedBox(height: spacing));
      }
    }

    return Column(
      key: key,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: childrenWithSpacing,
    );
  }
}
