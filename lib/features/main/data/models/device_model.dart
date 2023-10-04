// ignore_for_file: overridden_fields

import 'package:flutter_starter_app/features/main/domain/entities/device.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device_model.g.dart';

@JsonSerializable(includeIfNull: false)
class DeviceModel extends Device {
  @override
  final String? deviceUniqueIdentifier;
  @override
  final String? model;
  @override
  final String? brand;
  @override
  final String? timeZone;
  @override
  final String? notificationToken;
  @override
  final String? appBuildNumber;
  @override
  final String? systemVersion;

  const DeviceModel({
    this.deviceUniqueIdentifier,
    this.model,
    this.brand,
    this.appBuildNumber,
    this.systemVersion,
    this.timeZone,
    this.notificationToken,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);

  @override
  String toString() {
    return _$DeviceModelToJson(this).toString();
  }
}
