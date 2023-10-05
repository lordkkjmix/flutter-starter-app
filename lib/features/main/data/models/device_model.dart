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
  final String? deviceToken;
  @override
  final String? appBuildNumber;
  @override
  final String? systemVersion;
  @override
  final String? deviceType;
  @override
  final String? appVersion;
  @override
  final String? appIdentifier;
  @override
  final String? installerStore;
  @override
  final String? installationId;
  @override
  final String? deviceLocale;
  @override
  final String? buildSignature;

  const DeviceModel(
      {this.deviceUniqueIdentifier,
      this.model,
      this.brand,
      this.timeZone,
      this.deviceToken,
      this.appBuildNumber,
      this.systemVersion,
      this.deviceType,
      this.appVersion,
      this.appIdentifier,
      this.installerStore,
      this.installationId,
      this.deviceLocale,
      this.buildSignature});

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);

  @override
  String toString() {
    return _$DeviceModelToJson(this).toString();
  }
}
