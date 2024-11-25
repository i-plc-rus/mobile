import 'package:flutter/material.dart';
import 'package:mixkage_sber_code/common/theme/app_color_scheme.dart';
import 'package:mixkage_sber_code/common/theme/app_text_scheme.dart';

class CustomSection extends StatelessWidget {
  static const double horizontalPadding = 8;

  final String nameSection;
  final List<Widget> body;

  /// Creates a [CustomSection] widget.
  ///
  /// The [nameSection] and [body] parameters are required.
  /// The [key] parameter is optional.
  const CustomSection(this.nameSection, this.body, {super.key});

  @override
  Widget build(final BuildContext context) => ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              nameSection,
              style: AppTextScheme.of(context).settingsLabel,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColorScheme.of(context).onPrimary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(horizontalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: body,
              ),
            ),
          ),
        ],
      ),
    );
}
