import 'package:flutter/material.dart';

/// returns a template for an Alert dialog
///
/// takes a list of widgets [content] which are displayed in a column at the center of the dialog
///
/// takes a list of widgets [actions] which are displayed as actions on the alert dialog
///
mixin AppAlertDialog {
  static Widget alertDialog({
    required List<Widget> actions,
    required List<Widget> content,
  }) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: content.isNotEmpty
              ? const EdgeInsets.all(10)
              : const EdgeInsets.all(0),
          actionsPadding: actions.isNotEmpty
              ? const EdgeInsets.all(10)
              : const EdgeInsets.all(0),
          actionsAlignment: MainAxisAlignment.center,
          actions: actions,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: content,
          ),
        ),
      ),
    );
  }
}
