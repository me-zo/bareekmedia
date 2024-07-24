import 'package:bareekmedia/app/localization/resources.dart';
import 'package:bareekmedia/app/settings_notifier.dart';
import 'package:bareekmedia/features/home/screens/splash_screen.dart';
import 'package:bareekmedia/features/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bareekmedia/app/configuration.dart';
import 'package:bareekmedia/core/dependency_registrar/dependencies.dart';
import 'package:bareekmedia/features/actions/actions_view_model.dart';
import 'package:bareekmedia/features/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsNotifier>(
          create: (context) => sl<SettingsNotifier>(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider<ActionsViewModel>(
          create: (context) => ActionsViewModel(),
        ),
      ],
      builder: (context, __) => MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          breakpoints: const [
            ResponsiveBreakpoint.resize(400, name: MOBILE, scaleFactor: 1),
            ResponsiveBreakpoint.resize(800, name: TABLET, scaleFactor: 1.2),
          ],
        ),
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        scaffoldMessengerKey: Configuration.messengerKey,
        localizationsDelegates: const [
          Resources.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en"),
          Locale("ar"),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        locale: context.watch<SettingsNotifier>().getLocale,
        theme: context.watch<SettingsNotifier>().getTheme,
        darkTheme: context.watch<SettingsNotifier>().getTheme,
        onGenerateRoute: RouteGenerator().call,
        home: const SplashScreen(),
      ),
    );
  }
}
