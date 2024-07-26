// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Build { DEVELOP, RELEASE }

class Configuration {
  static final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey();
  final Build variant;
  final String domain;
  final String defaultErrorMessage;

  Configuration({
    required this.variant,
    required this.domain,
    required this.defaultErrorMessage,
  });
}
