import 'dart:io';

import 'package:bareekmedia/app/configuration.dart';
import 'package:bareekmedia/core/dependency_registrar/dependencies.dart';
import 'package:bareekmedia/core/logger.dart';

class NetworkConfig {
  static String bearerToken = "";

  String getBaseUrl() => "https://${sl<Configuration>().domain}";

  Map<String, String> getHeaders() => {};

  Future<bool> isConnected() async {
    bool hasConnection = false;
    try {
      final result = await InternetAddress.lookup('google.com');

      hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      Log.d(hasConnection
          ? "Internet Connection available."
          : "Internet connection not available.");
      return hasConnection;
    } catch (_) {
      return hasConnection;
    }
  }
}
