import 'package:flutter_starter_app/core/errors/exceptions.dart';
import 'package:flutter_starter_app/core/providers/device_provider.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';

abstract class AppSettingLocalDataSource {
  Future<DeviceModel> getDevice();
  Future<AppSettingModel> getSettings();
  Future<AppSettingModel?> getSetting(String settingIdentifier);
  Future<void> writeSetting(AppSettingModel setting);
}

class AppSettingLocalDataSourceImpl implements AppSettingLocalDataSource {
  final DeviceProvider deviceProvider;
  const AppSettingLocalDataSourceImpl({required this.deviceProvider});

  @override
  Future<AppSettingModel> getSettings({bool refresh = false}) async {
    try {
      /// TODO:Get saved api settings
      throw UnimplementedError();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> writeSetting(AppSettingModel setting) async {
    /// TODO:Save locally app setting
    try {
      throw UnimplementedError();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeviceModel> getDevice() async {
    try {
      return await deviceProvider.device;
    } catch (e) {
      throw PlatformException(message: e.toString());
    }
  }

  @override
  Future<AppSettingModel?> getSetting(String settingIdentifier) {
    // TODO: implement getSetting
    throw UnimplementedError();
  }
}
