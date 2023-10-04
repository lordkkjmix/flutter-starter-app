import 'package:equatable/equatable.dart';

class AppSetting extends Equatable {
  final String? appVersion;
  final int? appBuildNumber;
  final bool? isMandatoryUpdate;

  const AppSetting({
    this.appVersion,
    this.appBuildNumber,
    this.isMandatoryUpdate,
  });
  Map<String, dynamic> toMap() {
    return {
      'appVersion': appVersion,
      'appBuildNumber': appBuildNumber,
      'isMandatoryUpdate': isMandatoryUpdate,
    };
  }

  AppSetting copyWith({
    String? appVersion,
    int? appBuildNumber,
    bool? isMandatoryUpdate,
  }) {
    return AppSetting(
      appVersion: appVersion ?? this.appVersion,
      appBuildNumber: appBuildNumber ?? this.appBuildNumber,
      isMandatoryUpdate: isMandatoryUpdate ?? this.isMandatoryUpdate,
    );
  }

  @override
  List<Object?> get props => [
        appVersion,
        appBuildNumber,
        isMandatoryUpdate,
      ];
}
