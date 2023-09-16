import 'package:flutter/material.dart';
import 'package:flutter_starter_app/features/main/presentation/pages/main_page.dart';

class RouteProvider {
  ///You can use your custom route provider like GoRouter or Autoroute
  static const String start = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    start: (context) => const MainPage()
  };
}
