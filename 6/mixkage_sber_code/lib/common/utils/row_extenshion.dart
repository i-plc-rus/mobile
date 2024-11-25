// Расширение для добавления отступов между виджетами
import 'package:flutter/material.dart';

extension PaddingWidgets on Row {
  /// Создает новый [Row] с отступами между дочерними виджетами.
  Row withSpacing(final double spacing) {
    // Создаем список виджетов с отступами
    final childrenWithSpacing = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      childrenWithSpacing.add(children[i]);
      if (i < children.length - 1) {
        childrenWithSpacing.add(SizedBox(height: spacing));
      }
    }

    return Row(
      key: key,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: childrenWithSpacing,
    );
  }
}
