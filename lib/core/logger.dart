import 'dart:developer';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode, kIsWeb;

enum LogType { networkCalls, analytics, navigation, all }

class Log {
  static final List<LogType> _logTypesBeingDisplayed = [];

  /// initializes the Logger with the log types you want to see in a certain build of the application.
  static void initLogger({List<LogType> types = const []}) {
    _logTypesBeingDisplayed.addAll(types);
  }

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
  static void d(String text, {LogType? type}) {
    if (!kDebugMode) return;

    void logEvent() {
      if (kIsWeb) {
        debugPrint("\n$line$text\n$line\n");
      } else {
        log("\n$line$text\n$line\n");
      }
    }

    switch (type) {
      case LogType.analytics when _logTypesBeingDisplayed.contains(type):
        logEvent();
        break;
      case LogType.navigation when _logTypesBeingDisplayed.contains(type):
        logEvent();
        break;
      case LogType.networkCalls when _logTypesBeingDisplayed.contains(type):
        logEvent();
        break;
      // cover missing/uncategorized calls
      case null:
        logEvent();
        break;
      case _ when _logTypesBeingDisplayed.contains(LogType.all):
        logEvent();
        break;
      case _:
        break;
    }
  }
}
