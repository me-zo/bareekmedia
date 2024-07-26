import 'dart:async';
import 'dart:core';

import 'package:bareekmedia/common/app_snack_bar.dart';
import 'package:bareekmedia/core/errors/failure_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  FailureModel failure = const FailureModel();
  final WebViewController homeWebViewController = WebViewController();

  bool didClickBackOnce = false;

  Future<void> preloadWebView() async {
    setBusy();
    await Future.forEach([
      await homeWebViewController
          .setJavaScriptMode(JavaScriptMode.unrestricted),
      await homeWebViewController.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
        ),
      ),
      await homeWebViewController.loadRequest(
        Uri.parse('http://demo.bareekmedia.com/en/hp'),
        headers: {"source": "mobile"},
      ),
    ], (element) => null);
    setIdle();
  }

  void closeAppAfterSecondBackClick() async {
    if (await homeWebViewController.canGoBack()) {
      await homeWebViewController.goBack();
    } else {
      AppSnackBar.notificationSnackBar(
          message: "Click again to close the app.");
      didClickBackOnce = true;
      Timer(2.seconds, () {
        didClickBackOnce = false;
        notifyListeners();
      });
      notifyListeners();
    }
  }
}
