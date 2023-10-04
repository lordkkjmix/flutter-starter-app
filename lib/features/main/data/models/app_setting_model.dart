import 'package:flutter_starter_app/features/main/domain/entities/app_setting.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_setting_model.g.dart';

@JsonSerializable(includeIfNull: false)
class AppSettingModel extends AppSetting {
  const AppSettingModel({
    super.appVersion,
    super.appBuildNumber,
    super.isMandatoryUpdate,
  }) : super();

  factory AppSettingModel.fromJson(Map<String, dynamic> json) =>
      _$AppSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingModelToJson(this);

  @override
  String toString() {
    return _$AppSettingModelToJson(this).toString();
  }
}
