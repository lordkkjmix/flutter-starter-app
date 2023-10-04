import 'package:flutter/material.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';

class AlertHelper {
  const AlertHelper();
  static void displaySnackBar(
      {required String message, BuildContext? context}) async {
    final GlobalKey<ScaffoldMessengerState> messengerKey =
        sl<GlobalKey<ScaffoldMessengerState>>();
    final snackBar = SnackBar(
      content: Text(
        message,
        style: Theme.of(context ?? messengerKey.currentContext!)
            .textTheme
            .headlineMedium
            ?.copyWith(
              fontSize: 15,
            ),
      ),
      duration: const Duration(seconds: 3),
    );
    messengerKey.currentState?.showSnackBar(snackBar);
  }
}
