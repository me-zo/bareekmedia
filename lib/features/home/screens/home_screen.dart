import 'package:bareekmedia/features/actions/screens/settings_screen.dart';
import 'package:bareekmedia/features/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "/HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (cxt, viewModel, _) => PopScope(
        canPop: viewModel.didClickBackOnce,
        onPopInvoked: (didPop) => viewModel.closeAppAfterSecondBackClick(),
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterTop,
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsScreen.name),
            mini: true,
            child: const Icon(Icons.settings),
          ),
          body: Consumer<HomeViewModel>(
            builder: (context, model, _) {
              if (model.isBusy) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                );
              }
              return const _WebViewComponent();
            },
          ),
        ),
      ),
    );
  }
}

class _WebViewComponent extends StatelessWidget {
  const _WebViewComponent();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (cxt, viewModel, widget) => SafeArea(
        child: WebViewWidget(
          controller: viewModel.homeWebViewController,
        ),
      ),
    );
  }
}
