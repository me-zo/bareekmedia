import 'package:flutter/material.dart';
import 'package:bareekmedia/app/configuration.dart';
import 'package:bareekmedia/app/localization/resources.dart';

mixin AppSnackBar {
  static void notificationSnackBar({String message = ""}) {
    Configuration.messengerKey.currentState!.showSnackBar(
      _snackBarWidget(message: message, color: Colors.black.withOpacity(0.6)),
    );
  }

  static void errorSnackBar({String message = ""}) {
    Configuration.messengerKey.currentState!.showSnackBar(
      _snackBarWidget(
        message: message,
        color: Colors.red.withOpacity(0.9),
      ),
    );
  }

  static SnackBar _snackBarWidget({
    required String message,
    Color color = Colors.grey,
  }) {
    Configuration.messengerKey.currentState!.removeCurrentSnackBar();
    return SnackBar(
      content: Text(
        Resources.instance.get(message),
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      backgroundColor: color,
    );
  }
}
