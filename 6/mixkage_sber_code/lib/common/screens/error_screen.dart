import 'package:flutter/material.dart';
import 'package:mixkage_sber_code/l10n/l10n.dart';
// import 'package:tradehub/l10n/l10n.dart';

/// Экран, который показывается при загрузчке ошибочного роута
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                S.of(context).route_not_found,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 10,
                  color: const Color.fromARGB(255, 86, 64, 64),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
}
