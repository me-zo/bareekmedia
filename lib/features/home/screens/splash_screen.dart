import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_view_model.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String name = "/SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Provider.of<HomeViewModel>(context, listen: false).loadWebView();
        return Navigator.pushReplacementNamed(
          context,
          HomeScreen.name,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/logo.png"), context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Image(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "By\n Bareek Media",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
