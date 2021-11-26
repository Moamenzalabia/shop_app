import 'package:flutter/material.dart';

class AppNavigator {
  static void navigateToNext({
    required Widget nextScreen,
    required BuildContext context,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  static void navigateAndFinish({
    required Widget nextScreen,
    required BuildContext context,
  }) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => nextScreen,
          ), (route) {
        return false;
      });
}
