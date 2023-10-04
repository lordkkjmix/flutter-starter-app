// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettingModel _$AppSettingModelFromJson(Map<String, dynamic> json) =>
    AppSettingModel(
      appVersion: json['appVersion'] as String?,
      appBuildNumber: json['appBuildNumber'] as int?,
      isMandatoryUpdate: json['isMandatoryUpdate'] as bool?,
    );

Map<String, dynamic> _$AppSettingModelToJson(AppSettingModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appVersion', instance.appVersion);
  writeNotNull('appBuildNumber', instance.appBuildNumber);
  writeNotNull('isMandatoryUpdate', instance.isMandatoryUpdate);
  return val;
}
