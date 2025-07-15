import 'package:flutter/material.dart';

class DsSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    Widget? icon,
    Duration duration = const Duration(seconds: 5),
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [?icon, SizedBox(height: 8.0), Text(message)],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
