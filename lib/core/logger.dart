import 'dart:developer';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode, kIsWeb;

class Log {
  static String line =
      '────────────────────────────────────────────────────────────────────────\n';

  /// used for logging errors
  static void e(Object error) {
    if (kIsWeb && kDebugMode) {
      if (error is Error) {
        debugPrint("${line}Error Type: ${error.runtimeType}"
            "\nError Message: ${error.toString()}"
            "\nError Stacktrace: ${error.stackTrace}");
      } else {
        debugPrint("${line}Issue Type: ${error.runtimeType}"
            "\nIssue Message: ${error.toString()}");
      }
    } else {
      if (error is Error) {
        log("${line}Error Type: ${error.runtimeType}"
            "\nError Message: ${error.toString()}"
            "\nError Stacktrace: ${error.stackTrace}");
      } else {
        log("${line}Issue Type: ${error.runtimeType}"
            "\nIssue Message: ${error.toString()}");
      }
    }
  }

  /// used for logging debug messages
  static void d(String text) {
    if (kIsWeb && kDebugMode) {
      debugPrint("\n$line$text\n$line\n");
    } else {
      if (text.length > 100) {
        log("\n$line${text.substring(0, (text.length / 2).floor())}");
        log("${text.substring((text.length / 2).ceil(), text.length)}\n$line\n");
      } else {
        log("\n$line$text\n$line\n");
      }
    }
  }
}
