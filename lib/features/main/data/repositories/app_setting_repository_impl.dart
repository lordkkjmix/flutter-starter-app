import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_starter_app/core/errors/exceptions.dart';
import 'package:flutter_starter_app/core/errors/failures.dart';
import 'package:flutter_starter_app/core/providers/network_provider.dart';
import 'package:flutter_starter_app/core/utils/decode_utils.dart';
import 'package:flutter_starter_app/features/main/data/datasources/app_setting_local_data_source.dart';
import 'package:flutter_starter_app/features/main/data/datasources/app_setting_remote_data_source.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';
import 'package:flutter_starter_app/features/main/domain/entities/app_setting.dart';
import 'package:flutter_starter_app/features/main/domain/entities/device.dart';
import 'package:flutter_starter_app/features/main/domain/repositories/app_setting_repository.dart';

class AppSettingRepositoryImpl implements AppSettingRepository {
  final AppSettingLocalDataSource appSettingLocalDataSource;
  final AppSettingRemoteDataSource appSettingRemoteDataSource;
  final NetworkProvider networkProvider;
  AppSettingRepositoryImpl({
    required this.appSettingLocalDataSource,
    required this.appSettingRemoteDataSource,
    required this.networkProvider,
  });
  @override
  Future<Either<Failure, bool>> getConnectivity() async {
    try {
      return implementRepository<bool>(networkProvider.isConnected
          .then((value) async => await networkProvider.getInternetStatus));
    } catch (e) {
      return Left(ServerFailure(statusCode: -1, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<bool>>> getStreamConnectivity() async {
    try {
      final Stream<bool> connectivityStream =
          networkProvider.onConnectivityChanged;
      return Right(connectivityStream);
    } catch (e) {
      return Left(ServerFailure(statusCode: -1, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Device>> getDeviceInfo() async {
    try {
      return implementRepository<Device>(appSettingLocalDataSource.getDevice());
    } on RequestException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ServerFailure(statusCode: -1, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppSetting>>> getSettings(
      {bool refresh = false}) async {
    try {
      return implementRepository<List<AppSetting>>(
          appSettingRemoteDataSource.getSettings());
    } on RequestException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ServerFailure(statusCode: -1, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> writeSetting(
      {required AppSetting setting}) async {
    try {
      return implementRepository<void>(appSettingLocalDataSource
          .writeSetting(AppSettingModel.fromJson(setting.toMap())));
    } on RequestException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ServerFailure(statusCode: -1, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppSetting?>> getSetting(String settingIdentifier,
      {refresh = false}) async {
    try {
      return implementRepository<AppSetting?>(refresh
          ? appSettingRemoteDataSource.getSetting(settingIdentifier)
          : appSettingLocalDataSource.getSetting(settingIdentifier));
    } on RequestException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ServerFailure(statusCode: -1, message: e.toString()));
    }
  }
}
