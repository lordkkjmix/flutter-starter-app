import 'package:flutter/foundation.dart';
import 'package:flutter_starter_app/core/common/alert_error_widget.dart';
import 'package:flutter_starter_app/core/providers/navigation_provider.dart';

class ErrorHandleProvider {
  static Future<void> initialize() async {}
  static void onFlutterError(FlutterErrorDetails flutterErrorDetails) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(flutterErrorDetails);
    }
    FlutterError.presentError(flutterErrorDetails);
    NavigationProvider.dialog(AlertErrorWidget(
      errorMessage: flutterErrorDetails.exception.toString(),
    ));
  }

  static bool onPlatformError(error, stack) {
    NavigationProvider.dialog(
      AlertErrorWidget(
        errorMessage: error.toString(),
      ),
    );
    return true;
  }
}
