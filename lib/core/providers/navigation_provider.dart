import 'package:flutter/material.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';

class NavigationProvider {
  //Use navigation provider to navigate in the app globally without set th context, because context passed in the injector
  //You can use your own route provider
  static final GlobalKey<NavigatorState> _navigatorKey =
      sl<GlobalKey<NavigatorState>>();

  static BuildContext? context = _navigatorKey.currentContext;

  static toNamed(String routeName, {Object? arguments}) {
    Navigator.pushNamed(context!, routeName, arguments: arguments);
  }

  static offNamed(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context!, routeName, arguments: arguments);
  }

  static offAllNamed(String routeName,
      {Object? arguments, bool Function(Route<dynamic>)? predicate}) {
    if (context != null) {
      Navigator.pushNamedAndRemoveUntil(
          context!, routeName, predicate ?? (Route<dynamic> route) => false,
          arguments: arguments);
    }
  }

  static Future<dynamic>? to(
    Widget widget, {
    bool fullScreenDialog = false,
    bool preventDuplicates = false,
    bool withoutAnimation = false,
  }) {
    final String destinationRouteName =
        widget.runtimeType.toString().toLowerCase();

    final String? currentRoute = currentRouteName();

    if (preventDuplicates && currentRoute == destinationRouteName) {
      return null;
    }

    if (withoutAnimation) {
      return Navigator.push(
        context!,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => widget,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          fullscreenDialog: fullScreenDialog,
          settings: RouteSettings(
            name: widget.key != null
                ? widget.key.toString().toLowerCase()
                : widget.toString().toLowerCase(),
          ),
        ),
      );
    } else {
      return Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) => widget,
          fullscreenDialog: fullScreenDialog,
          settings: RouteSettings(
            name: widget.key != null
                ? widget.key.toString().toLowerCase()
                : widget.toString().toLowerCase(),
          ),
        ),
      );
    }
  }

  static off(Widget widget, {bool fullScreenDialog = false}) {
    return Navigator.pushReplacement(
      context!,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullScreenDialog,
        settings: RouteSettings(
          name: widget.key != null
              ? widget.key.toString().toLowerCase()
              : widget.toString().toLowerCase(),
        ),
      ),
    );
  }

  ///Just use [popUntil] with generated route
  static popUntil(bool Function(Route<dynamic>) predicate) {
    return Navigator.of(context!).popUntil(predicate);
  }

  static offAll(Widget widget, {bool Function(Route<dynamic>)? predicate}) {
    Navigator.pushAndRemoveUntil(
      context!,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(
          name: widget.key != null
              ? widget.key.toString().toLowerCase()
              : widget.toString().toLowerCase(),
        ),
      ),
      predicate ?? (Route<dynamic> route) => false,
    );
  }

  static back([result]) {
    if (canPop()) {
      Navigator.pop(context!, result);
    }
  }

  static bool canPop() {
    return Navigator.canPop(context!);
  }

  static String? currentRouteName() {
    return ModalRoute.of(context!)?.settings.name;
  }

  static String? previousRouteName() {
    return ModalRoute.of(context!)?.settings.name;
  }

  static ModalRoute? modalRoute() {
    return ModalRoute.of(context!);
  }

  static BuildContext? currentBuildContext() {
    return context;
  }

  static dynamic dialog(Widget content,
      {bool barrierDismissible = true, String? barrierLabel, String? name}) {
    if (context != null) {
      showDialog(
        context: context!,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        routeSettings: name != null ? RouteSettings(name: name) : null,
        builder: (BuildContext context) => content,
      );
    }
  }

  static dynamic bottomSheet(
    Widget content, {
    bool isScrollControlled = false,
    bool ignoreSafeArea = false,
  }) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context!,
      builder: (BuildContext context) => content,
      isScrollControlled: isScrollControlled,
    );
  }
}
