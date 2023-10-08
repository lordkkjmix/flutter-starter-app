import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';
import 'package:flutter_starter_app/features/main/domain/entities/app_setting.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late AppSettingModel appSettingModel;
  late AppSetting appSettingEntity;

  final appSettingModelBody = jsonDecode(fixture('app_setting_model.json'));
  setUp(() {
    appSettingModel = AppSettingModel.fromJson(appSettingModelBody);
    appSettingEntity = appSettingModel;
  });
  group("type", () {
    test("should be a subclass of AppSetting entity", () {
      expect(appSettingModel, isA<AppSetting>());
    });

    test("should be a subclass of Equatable", () {
      expect(appSettingModel, isA<Equatable>());
    });
  });

  group("toJson", () {
    test("should return a JSON map containing the proper data", () {
      final result = appSettingModel.toJson();
      expect(result, appSettingModel.toJson());
    });
  });
  group("fromEntity", () {
    test("should return a AppSettingModel given an entity AppSetting", () {
      final entity = AppSettingModel.fromJson(appSettingEntity.toMap());
      expect(entity, isA<AppSettingModel>());
    });
  });
  group("toEntity", () {
    test("should return a valid entity", () {
      final result = appSettingModel;
      expect(result, isA<AppSetting>());
    });
  });

  group("fromJson", () {
    test("should return a  appSettingModel given a JSON map", () {
      final result = AppSettingModel.fromJson(appSettingModelBody);
      expect(result, isA<AppSettingModel>());
    });
  });

  test('copyWith should create a new AppSetting with updated values', () {
    final updatedSetting = appSettingEntity.copyWith(
      appVersion: '2.0',
      appBuildNumber: "456",
      isMandatoryUpdate: true,
    );

    // Verify that updatedSetting has the updated values
    expect(updatedSetting.appVersion, '2.0');
    expect(updatedSetting.appBuildNumber, "456");
    expect(updatedSetting.isMandatoryUpdate, true);
  });
}
