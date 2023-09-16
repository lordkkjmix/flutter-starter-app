import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter_app/core/constants/constant.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';
import 'package:flutter_starter_app/core/providers/localization_provider.dart';
import 'package:flutter_starter_app/core/providers/route_provider.dart';
import 'package:flutter_starter_app/core/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectorProvider.init();
  await LocalizationProvider.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver, RouteAware {
  Locale locale = LocalizationProvider.currentLocale;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    LocalizationProvider.onLocaleChanged = onLocaleChange;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      locale = locale;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!mounted) return;
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
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
      localizationsDelegates: [
        LocalizationProvider.localeDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: LocalizationProvider.currentLocale,
      supportedLocales: LocalizationProvider.supportedLocales,
    );
  }
}
