import 'package:dartz/dartz.dart';
import 'package:flutter_starter_app/core/errors/failures.dart';
import 'package:flutter_starter_app/features/main/domain/entities/app_setting.dart';
import 'package:flutter_starter_app/features/main/domain/entities/device.dart';

abstract class AppSettingRepository {
  Future<Either<Failure, List<AppSetting>>> getSettings({bool refresh = false});
  Future<Either<Failure, AppSetting?>> getSetting(String settingId,
      {refresh = false});
  Future<Either<Failure, void>> writeSetting({required AppSetting setting});
  Future<Either<Failure, Stream<bool>>> getStreamConnectivity();
  Future<Either<Failure, bool>> getConnectivity();
  Future<Either<Failure, Device>> getDeviceInfo();
}
