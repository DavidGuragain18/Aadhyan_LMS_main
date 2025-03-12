import 'package:flutter/material.dart';

showSnackBar({
  required String message,
  required BuildContext context,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
      backgroundColor: color ?? Colors.green,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
