import 'package:flutter/material.dart';

class CustomSnackBar {
  static void display(BuildContext context, SnackBar snackBar){
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static SnackBar get(String message) {
    return SnackBar(
      width: 450,
      content: Text(message),
      action: SnackBarAction(
        label: '',
        textColor: Colors.white,
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.purple,
    );
  }
}