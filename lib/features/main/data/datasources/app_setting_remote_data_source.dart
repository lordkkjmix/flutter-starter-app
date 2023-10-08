import 'package:flutter_starter_app/core/providers/request_provider.dart';
import 'package:flutter_starter_app/core/utils/decode_utils.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';

abstract class AppSettingRemoteDataSource {
  Future<List<AppSettingModel>> getSettings();
  Future<AppSettingModel?> getSetting(String settingIdentifier);
}

class AppSettingRemoteDataSourceImpl implements AppSettingRemoteDataSource {
  final RequestProvider requestProvider;
  AppSettingRemoteDataSourceImpl({required this.requestProvider});

  @override
  Future<List<AppSettingModel>> getSettings() async {
    try {
      return await requestProvider.get("/").then((value) =>
          decodeDataSourceResponse<AppSettingModel>(value.data,
              decoder: ((item) => AppSettingModel.fromJson(item))));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppSettingModel?> getSetting(String settingIdentifier) async {
    try {
      return await requestProvider.get("/").then((value) =>
          decodeDataSourceResponse<AppSettingModel>(value.data,
              decoder: ((item) => AppSettingModel.fromJson(item))));
    } catch (e) {
      rethrow;
    }
  }
}
