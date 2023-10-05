import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String? deviceUniqueIdentifier;
  final String? model;
  final String? brand;
  final String? timeZone;
  final String? deviceToken;
  final String? appBuildNumber;
  final String? systemVersion;
  final String? deviceType;
  final String? appVersion;
  final String? appIdentifier;
  final String? installerStore;
  final String? installationId;
  final String? deviceLocale;

  const Device({
    this.deviceUniqueIdentifier,
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
  });
  Device copyWith({
    String? deviceUniqueIdentifier,
    String? model,
    String? brand,
    String? timeZone,
    String? deviceToken,
    String? appBuildNumber,
    String? systemVersion,
    String? deviceType,
    String? appVersion,
    String? appIdentifier,
    String? installerStore,
    String? installationId,
    String? deviceLocale,
  }) {
    return Device(
      deviceUniqueIdentifier:
          deviceUniqueIdentifier ?? this.deviceUniqueIdentifier,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      timeZone: timeZone ?? this.timeZone,
      deviceToken: deviceToken ?? this.deviceToken,
      appBuildNumber: appBuildNumber ?? this.appBuildNumber,
      systemVersion: systemVersion ?? this.systemVersion,
      deviceType: deviceType ?? this.deviceType,
      appVersion: appVersion ?? this.appVersion,
      appIdentifier: appIdentifier ?? this.appIdentifier,
      installerStore: installerStore ?? this.installerStore,
      installationId: installationId ?? this.installationId,
      deviceLocale: deviceLocale ?? this.deviceLocale,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceUniqueIdentifier': deviceUniqueIdentifier,
      'model': model,
      'brand': brand,
      'timeZone': timeZone,
      'notificationToken': deviceToken,
      'appBuildNumber': appBuildNumber,
      'systemVersion': systemVersion,
      'deviceType': deviceType,
      'appVersion': appVersion,
      'appIdentifier': appIdentifier,
      'installerStore': installerStore,
      'installationId': installationId,
      'deviceLocale': deviceLocale,
    };
  }

  @override
  List<Object?> get props => [
        deviceUniqueIdentifier,
        model,
        brand,
        timeZone,
        deviceToken,
        appBuildNumber,
        systemVersion,
        deviceType,
        appVersion,
        appIdentifier,
        installerStore,
        installationId,
        deviceLocale,
      ];
}
