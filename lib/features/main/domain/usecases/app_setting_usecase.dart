import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_starter_app/core/errors/failures.dart';
import 'package:flutter_starter_app/core/usescases/usecases.dart';
import 'package:flutter_starter_app/features/main/domain/entities/app_setting.dart';
import 'package:flutter_starter_app/features/main/domain/entities/device.dart';
import 'package:flutter_starter_app/features/main/domain/repositories/app_setting_repository.dart';

class AppSettingUseCase extends UseCase<Device, NoParams> {
  final AppSettingRepository appSettingRepository;

  AppSettingUseCase({required this.appSettingRepository});
  @override
  Future<Either<Failure, Device>> call(NoParams params) async {
    return await appSettingRepository.getDeviceInfo();
  }

  Future<Either<Failure, Stream<bool>>> getStreamConnectivity(
      NoParams params) async {
    return await appSettingRepository.getStreamConnectivity();
  }

  Future<Either<Failure, bool>> getConnectivity(NoParams params) async {
    return await appSettingRepository.getConnectivity();
  }

  Future<Either<Failure, List<AppSetting>>> getSettings(NoParams params) async {
    return await appSettingRepository.getSettings();
  }
}

class Params extends Equatable {
  final String? settingId;
  final String? settingValue;
  final bool? refresh;

  const Params({this.refresh = false, this.settingId, this.settingValue});

  @override
  List<Object?> get props => [refresh, settingId, settingValue];
}
