import 'dart:io';

import 'package:bareekmedia/app/app.dart';
import 'package:bareekmedia/app/configuration.dart';
import 'package:bareekmedia/core/dependency_registrar/dependencies.dart';
import 'package:bareekmedia/core/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(_extractBuildFromDartDefinedVariable());

  Animate.restartOnHotReload = true;
  //TODO: REMOVE IN PRODUCTION (for overriding http certificates)
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

// TODO: REMOVE IN PRODUCTION (for overriding http certificates)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Build _extractBuildFromDartDefinedVariable() {
  //throws an exception if not found (We need the app to error on launch so we avoid build environment confusion)
  var build = Build.values
      .byName(const String.fromEnvironment("Build", defaultValue: "DEVELOP"));
  Log.d("A ${build.name} Build is starting up...");
  return build;
}
