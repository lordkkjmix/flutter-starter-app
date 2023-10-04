// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      deviceUniqueIdentifier: json['deviceUniqueIdentifier'] as String?,
      model: json['model'] as String?,
      brand: json['brand'] as String?,
      appBuildNumber: json['appBuildNumber'] as String?,
      systemVersion: json['systemVersion'] as String?,
      timeZone: json['timeZone'] as String?,
      notificationToken: json['notificationToken'] as String?,
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
  writeNotNull('notificationToken', instance.notificationToken);
  writeNotNull('appBuildNumber', instance.appBuildNumber);
  writeNotNull('systemVersion', instance.systemVersion);
  return val;
}
