import 'package:flutter/material.dart';
import 'package:flutter_starter_app/core/constants/constant.dart';
import 'package:flutter_starter_app/core/providers/route_provider.dart';
import 'package:flutter_starter_app/core/providers/theme_provider.dart';
import 'package:flutter_starter_app/features/main/presentation/pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    const appName = Constant.appName;

    ///Change this stat to update the app Light Theme
    ThemeData currentLightTheme = ThemeProvider.lightTheme;

    ///Change this stat to update the app Dark Theme
    ThemeData currentDarkTheme = ThemeProvider.darkTheme;
    return MaterialApp(
      title: appName,
      theme: currentLightTheme,
      darkTheme: currentDarkTheme,
      themeMode: ThemeMode.system,
      initialRoute: RouteProvider.start,
      routes: RouteProvider.routes,
    );
  }
}
