import 'package:bareekmedia/core/logger.dart';
import 'package:bareekmedia/features/actions/screens/settings_screen.dart';
import 'package:bareekmedia/features/home/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'home/screens/home_screen.dart';

class RouteGenerator {
  Route? call(RouteSettings routeSettings) => FadePageRoute<void>(
        settings: routeSettings,
        arguments: routeSettings.arguments,
        builder: (BuildContext context) => switch (routeSettings.name) {
          (SettingsScreen.name) => const SettingsScreen(),
          (HomeScreen.name) => const HomeScreen(),
          (SplashScreen.name) => const SplashScreen(),
          (_) => const HomeScreen(),
        },
      );
}

class FadePageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final String? name;
  final Object? arguments;

  FadePageRoute(
      {required this.builder, this.name, this.arguments, super.settings});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Log.d(
      "Building screen \b$name through a Named Route with arguments: $arguments",
      type: LogType.analytics,
    );
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
