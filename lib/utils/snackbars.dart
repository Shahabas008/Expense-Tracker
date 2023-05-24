import 'package:flutter/material.dart';

class Snack {
  static showSnackbar({
    required BuildContext context,
    required message,
  }) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
