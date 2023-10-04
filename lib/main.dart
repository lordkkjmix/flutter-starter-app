import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter_app/core/constants/constant.dart';
import 'package:flutter_starter_app/core/helpers/alert_helper.dart';
import 'package:flutter_starter_app/core/providers/error_handle_provider.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';
import 'package:flutter_starter_app/core/providers/localization_provider.dart';
import 'package:flutter_starter_app/core/providers/route_provider.dart';
import 'package:flutter_starter_app/core/providers/theme_provider.dart';
import 'package:flutter_starter_app/features/main/presentation/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_starter_app/features/main/presentation/cubit/connectivity_cubit/connectivity_cubit.dart';
import 'package:flutter_starter_app/i18n/i18n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectorProvider.init();
  await LocalizationProvider.initialize();
  FlutterError.onError =
      (details) => ErrorHandleProvider.onFlutterError(details);
  PlatformDispatcher.instance.onError = (error, stackTrace) =>
      ErrorHandleProvider.onPlatformError(error, stackTrace);
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<ConnectivityCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<AppCubit>(),
          ),
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<ConnectivityCubit, ConnectivityState>(
                listener: (context, connectivityState) {
                  final String message =
                      connectivityState is ConnectivitySuccess
                          ? "Internet connection restored".translate
                          : "Internet connection lost".translate;
                  if (connectivityState is ConnectivityFailure ||
                      connectivityState is ConnectivitySuccess) {
                    if (connectivityState.displayMessage) {
                      AlertHelper.displaySnackBar(message: message);
                    }
                    context.read<ConnectivityCubit>().getConnectivityStream();
                  }
                },
              ),
            ],
            child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
                builder: (context, connectivityState) {
              if (connectivityState is ConnectivityInitial) {
                context.read<ConnectivityCubit>().getConnectivity();
                context.read<AppCubit>().initializeApp();
              }
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
                navigatorKey: sl<GlobalKey<NavigatorState>>(),
                scaffoldMessengerKey: sl<GlobalKey<ScaffoldMessengerState>>(),
              );
            })));
  }
}
