import 'dart:convert';

import 'package:flutter_starter_app/core/constants/constant.dart';
import 'package:flutter_starter_app/core/errors/exceptions.dart';
import 'package:flutter_starter_app/core/providers/device_provider.dart';
import 'package:flutter_starter_app/core/providers/storage_provider.dart';
import 'package:flutter_starter_app/core/utils/decode_utils.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';

abstract class AppSettingLocalDataSource {
  Future<DeviceModel> getDevice();
  Future<List<AppSettingModel>> getSettings();
  Future<AppSettingModel?> getSetting(String settingIdentifier);
  Future<void> writeSetting(AppSettingModel setting);
  Future<void> delete(setting);
  Future<void> deleteAll();
}

class AppSettingLocalDataSourceImpl implements AppSettingLocalDataSource {
  final DeviceProvider deviceProvider;
  final StorageProvider storageProvider;
  const AppSettingLocalDataSourceImpl(
      {required this.deviceProvider, required this.storageProvider});

  @override
  Future<List<AppSettingModel>> getSettings() async {
    try {
      return await storageProvider
          .get(Constant.appStorageBoxKey, Constant.appSettingsLocalStorageKey)
          .then((value) => value != null
              ? decodeDataSourceResponse<AppSettingModel>(json.decode(value),
                  decoder: (item) => AppSettingModel.fromJson(item))
              : <AppSettingModel>[]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> writeSetting(AppSettingModel setting) async {
    try {
      return await storageProvider.save(Constant.appStorageBoxKey,
          Constant.appSettingsLocalStorageKey, json.encode(setting.toMap()));
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
  Future<AppSettingModel?> getSetting(String settingIdentifier) async {
    try {
      return await storageProvider
          .get(Constant.appStorageBoxKey, settingIdentifier)
          .then((value) => value != null
              ? decodeDataSourceResponse<AppSettingModel>(
                  Map<String, dynamic>.from((json.decode(value))),
                  decoder: (item) => AppSettingModel.fromJson(item))
              : null);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(setting) async {
    try {
      return await storageProvider.delete(
          Constant.appStorageBoxKey, Constant.appSettingsLocalStorageKey);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      return await storageProvider.deleteAll();
    } catch (e) {
      throw CacheException();
    }
  }
}
