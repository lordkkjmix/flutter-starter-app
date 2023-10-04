import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String? deviceUniqueIdentifier;
  final String? model;
  final String? brand;
  final String? timeZone;
  final String? notificationToken;
  final String? appBuildNumber;
  final String? systemVersion;

  const Device({
    this.deviceUniqueIdentifier,
    this.model,
    this.brand,
    this.timeZone,
    this.notificationToken,
    this.appBuildNumber,
    this.systemVersion,
  });
  Device copyWith({
    String? deviceUniqueIdentifier,
    String? model,
    String? brand,
    String? timeZone,
    String? notificationToken,
    String? appBuildNumber,
    String? systemVersion,
  }) {
    return Device(
      deviceUniqueIdentifier:
          deviceUniqueIdentifier ?? this.deviceUniqueIdentifier,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      timeZone: timeZone ?? this.timeZone,
      notificationToken: notificationToken ?? this.notificationToken,
      appBuildNumber: appBuildNumber ?? this.appBuildNumber,
      systemVersion: systemVersion ?? this.systemVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceUniqueIdentifier': deviceUniqueIdentifier,
      'model': model,
      'brand': brand,
      'timeZone': timeZone,
      'notificationToken': notificationToken,
      'appBuildNumber': appBuildNumber,
      'systemVersion': systemVersion,
    };
  }

  @override
  List<Object?> get props => [
        deviceUniqueIdentifier,
        model,
        brand,
        timeZone,
        notificationToken,
        appBuildNumber,
        systemVersion,
      ];
}
