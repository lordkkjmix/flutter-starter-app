import 'dart:io';

import 'package:flutter_starter_app/core/providers/request_provider.dart';
import 'package:flutter_starter_app/core/utils/decode_utils.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';

abstract class AppSettingRemoteDataSource {
  Future<List<AppSettingModel>> getSettings();
  Future<AppSettingModel?> getSetting(String settingIdentifier);
  Future<bool> getInternetStatus();
}

class AppSettingRemoteDataSourceImpl implements AppSettingRemoteDataSource {
  final RequestProvider requestProvider;
  AppSettingRemoteDataSourceImpl({required this.requestProvider});

  @override
  Future<List<AppSettingModel>> getSettings() async {
    return await requestProvider.get("/").then((value) =>
        decodeDataSourceResponse<AppSettingModel>(value,
            decoder: ((item) => AppSettingModel.fromJson(item))));
  }

  @override
  Future<AppSettingModel?> getSetting(String settingIdentifier) async {
    return await requestProvider.get("/").then((value) =>
        decodeDataSourceResponse<AppSettingModel>(value,
            decoder: ((item) => AppSettingModel.fromJson(item))));
  }

  @override
  Future<bool> getInternetStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
