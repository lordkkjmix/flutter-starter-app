// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      deviceUniqueIdentifier: json['deviceUniqueIdentifier'] as String?,
      model: json['model'] as String?,
      brand: json['brand'] as String?,
      timeZone: json['timeZone'] as String?,
      deviceToken: json['deviceToken'] as String?,
      appBuildNumber: json['appBuildNumber'] as String?,
      systemVersion: json['systemVersion'] as String?,
      deviceType: json['deviceType'] as String?,
      appVersion: json['appVersion'] as String?,
      appIdentifier: json['appIdentifier'] as String?,
      installerStore: json['installerStore'] as String?,
      installationId: json['installationId'] as String?,
      deviceLocale: json['deviceLocale'] as String?,
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deviceUniqueIdentifier', instance.deviceUniqueIdentifier);
  writeNotNull('model', instance.model);
  writeNotNull('brand', instance.brand);
  writeNotNull('timeZone', instance.timeZone);
  writeNotNull('deviceToken', instance.deviceToken);
  writeNotNull('appBuildNumber', instance.appBuildNumber);
  writeNotNull('systemVersion', instance.systemVersion);
  writeNotNull('deviceType', instance.deviceType);
  writeNotNull('appVersion', instance.appVersion);
  writeNotNull('appIdentifier', instance.appIdentifier);
  writeNotNull('installerStore', instance.installerStore);
  writeNotNull('installationId', instance.installationId);
  writeNotNull('deviceLocale', instance.deviceLocale);
  return val;
}
