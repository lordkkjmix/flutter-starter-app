import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';
import 'package:flutter_starter_app/features/main/domain/entities/device.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late DeviceModel deviceModel;
  late Device deviceEntity;

  final deviceModelBody = jsonDecode(fixture('device_model.json'));
  setUp(() {
    deviceModel = DeviceModel.fromJson(deviceModelBody);
    deviceEntity = deviceModel;
  });
  group("type", () {
    test("should be a subclass of Device entity", () {
      expect(deviceModel, isA<Device>());
    });

    test("should be a subclass of Equatable", () {
      expect(deviceModel, isA<Equatable>());
    });
  });

  group("toJson", () {
    test("should return a JSON map containing the proper data", () {
      final result = deviceModel.toJson();
      expect(result, deviceModelBody);
    });
  });
  group("fromEntity", () {
    test("should return a DeviceModel given an entity Device", () {
      final entity = DeviceModel.fromJson(deviceEntity.toMap());
      expect(entity, isA<DeviceModel>());
    });
  });
  group("toEntity", () {
    test("should return a valid entity", () {
      final result = deviceModel;
      expect(result, isA<Device>());
    });
  });

  group("fromJson", () {
    test("should return a deviceModel given a JSON map", () {
      final result = DeviceModel.fromJson(deviceModelBody);
      expect(result, isA<DeviceModel>());
    });
  });
  test('copyWith should create a new Device with updated values', () {
    final updatedDevice = deviceEntity.copyWith(
      model: 'Model B',
      brand: 'Brand Y',
      notificationToken: 'newToken',
    );
    // Verify that updatedDevice has the updated values
    expect(updatedDevice.model, 'Model B');
    expect(updatedDevice.brand, 'Brand Y');
    expect(updatedDevice.notificationToken, 'newToken');
  });
}
