import 'package:flutter/material.dart';

/*

This widget is used to show a snackbar with a message and a background color.
It is used to show a success, error, or warning message to the user.

*/

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Center(child: Text(message)),

        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }

  static void success(BuildContext context, String message) {
    show(context, message: message, backgroundColor: Colors.green);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, backgroundColor: Colors.red);
  }

  static void warning(BuildContext context, String message) {
    show(context, message: message, backgroundColor: Colors.orange);
  }
}
