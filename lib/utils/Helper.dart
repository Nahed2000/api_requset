import 'package:flutter/material.dart';

mixin Helper {
  void showSnackBar(BuildContext context,
      {required String message, required bool status}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: status ?Colors.red: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
