import 'package:flutter/material.dart';

abstract class CustomSnackbar {
  const CustomSnackbar();

  static void showSnackBar(final BuildContext context, final String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
