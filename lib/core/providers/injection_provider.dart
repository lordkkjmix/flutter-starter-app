import 'package:android_id/android_id.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/core/providers/device_provider.dart';
import 'package:flutter_starter_app/core/providers/network_provider.dart';
import 'package:flutter_starter_app/core/providers/request_provider.dart';
import 'package:flutter_starter_app/features/main/data/datasources/app_setting_local_data_source.dart';
import 'package:flutter_starter_app/features/main/data/datasources/app_setting_remote_data_source.dart';
import 'package:flutter_starter_app/features/main/data/repositories/app_setting_repository_impl.dart';
import 'package:flutter_starter_app/features/main/domain/repositories/app_setting_repository.dart';
import 'package:flutter_starter_app/features/main/domain/usecases/app_setting_usecase.dart';
import 'package:flutter_starter_app/features/main/presentation/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_starter_app/features/main/presentation/cubit/connectivity_cubit/connectivity_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();

class InjectorProvider {
  ///Global Dependencies injection
  static Future<void> init() async {
    //Cubit
    sl.registerFactory(
      () => ConnectivityCubit(settingUseCase: sl()),
    );
    sl.registerFactory(
      () => AppCubit(settingUseCase: sl()),
    );
    //UseCase
    sl.registerLazySingleton(
        () => AppSettingUseCase(appSettingRepository: sl()));
    //Repository
    sl.registerLazySingleton<AppSettingRepository>(
      () => AppSettingRepositoryImpl(
        appSettingLocalDataSource: sl(),
        appSettingRemoteDataSource: sl(),
        networkProvider: sl(),
      ),
    );
    // Data sources
    sl.registerLazySingleton<AppSettingLocalDataSource>(
      () => AppSettingLocalDataSourceImpl(deviceProvider: sl()),
    );
    sl.registerLazySingleton<AppSettingRemoteDataSource>(
      () => AppSettingRemoteDataSourceImpl(requestProvider: sl()),
    );

    //Core
    sl.registerLazySingleton<NetworkProvider>(() => NetworkInfoImpl());
    sl.registerLazySingleton<DeviceProvider>(() => DeviceProviderImpl());
    sl.registerLazySingleton<RequestProvider>(
        () => const RequestProviderImpl());
    sl.registerLazySingleton(() => navigatorKey);
    sl.registerLazySingleton(() => messengerKey);
    //Shared
    //External;
    sl.registerLazySingleton(() => const AndroidId());
    sl.registerLazySingleton(() => Connectivity());
    sl.registerLazySingleton(() => DeviceInfoPlugin());
  }
}
