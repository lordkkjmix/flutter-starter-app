import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();

class InjectorProvider {
  ///Global Dependencies injection
  static Future<void> init() async {
    //Cubit
    //UseCase
    //Repository
    //Data sources
    //Core
    //Shared
    //External;
    sl.registerLazySingleton(() => navigatorKey);
  }
}
