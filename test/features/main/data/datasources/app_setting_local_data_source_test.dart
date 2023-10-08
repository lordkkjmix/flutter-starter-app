import 'dart:convert';

import 'package:flutter_starter_app/core/constants/constant.dart';
import 'package:flutter_starter_app/core/errors/exceptions.dart';
import 'package:flutter_starter_app/core/providers/device_provider.dart';
import 'package:flutter_starter_app/core/providers/storage_provider.dart';
import 'package:flutter_starter_app/features/main/data/datasources/app_setting_local_data_source.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'app_setting_local_data_source_test.mocks.dart';

@GenerateMocks([DeviceProvider, StorageProvider])
void main() {
  late AppSettingLocalDataSourceImpl localDataSource;
  late MockDeviceProvider mockDeviceProvider;
  late MockStorageProvider mockStorageProvider;
  late DeviceModel deviceModel;
  late AppSettingModel appSettingModel;
  final deviceModelBody = jsonDecode(fixture('device_model.json'));
  final appSettingModelBody = jsonDecode(fixture('device_model.json'));

  setUp(() {
    mockDeviceProvider = MockDeviceProvider();
    mockStorageProvider = MockStorageProvider();
    localDataSource = AppSettingLocalDataSourceImpl(
      deviceProvider: mockDeviceProvider,
      storageProvider: mockStorageProvider,
    );
    deviceModel = DeviceModel.fromJson(deviceModelBody);
    appSettingModel = AppSettingModel.fromJson(appSettingModelBody);
  });

  group('getDevice', () {
    test('should return a DeviceModel when successful', () async {
      // Arrange
      when(mockDeviceProvider.device).thenAnswer((_) async => deviceModel);

      // Act
      final result = await localDataSource.getDevice();

      // Assert
      expect(result, equals(deviceModel));
    });

    test('should throw a PlatformException on error', () {
      // Arrange
      when(mockDeviceProvider.device).thenThrow(Exception('Some error'));

      // Act
      final call = localDataSource.getDevice;

      // Assert
      expect(() => call(), throwsA(isInstanceOf<PlatformException>()));
    });
  });

  group('getSettings', () {
    test('should return an List of AppSettingModel when successful', () async {
      // Arrange
      final fakeJsonString = [json.encode(appSettingModel.toMap())].toString();
      when(mockStorageProvider.get(
              Constant.appStorageBoxKey, Constant.appSettingsLocalStorageKey))
          .thenAnswer((_) async => fakeJsonString);
      // Act
      final result = await localDataSource.getSettings();

      // Assert
      expect(result, equals([appSettingModel]));
    });

    test('should throw an exception on error', () {
      // Arrange
      when(mockStorageProvider.get(
              Constant.appStorageBoxKey, Constant.appSettingsLocalStorageKey))
          .thenThrow(Exception('Some error'));

      // Act
      final call = localDataSource.getSettings;

      // Assert
      expect(() => call(), throwsException);
    });
  });

  group('writeSetting', () {
    test('should write an AppSettingModel successfully', () async {
      // Arrange

      // Act
      await localDataSource.writeSetting(appSettingModel);

      // Assert
      verify(mockStorageProvider.save(
          Constant.appStorageBoxKey,
          Constant.appSettingsLocalStorageKey,
          json.encode(appSettingModel.toMap())));
    });

    test('should throw an exception on error', () {
      // Arrange
      when(mockStorageProvider.save(Constant.appStorageBoxKey,
              Constant.appSettingsLocalStorageKey, any))
          .thenThrow(Exception('Some error'));

      // Act
      final call = localDataSource.writeSetting;

      // Assert
      expect(() => call(appSettingModel), throwsException);
    });
  });

  group('getSetting', () {
    test('should return an AppSettingModel when successful', () async {
      // Arrange
      final fakeJsonString = json.encode(appSettingModel.toMap()).toString();
      when(mockStorageProvider.get(Constant.appStorageBoxKey, 'someIdentifier'))
          .thenAnswer((_) async => fakeJsonString);
      // Act
      final result = await localDataSource.getSetting('someIdentifier');
      // Assert
      expect(result, equals(appSettingModel));
    });
  });
  group('deleteSetting', () {
    test('should delete an AppSettingModel successfully', () async {
      // Arrange
      when(mockStorageProvider.delete(
              Constant.appStorageBoxKey, Constant.appSettingsLocalStorageKey))
          .thenAnswer((_) async {});
      when(mockStorageProvider.get(
              Constant.appStorageBoxKey, Constant.appSettingsLocalStorageKey))
          .thenAnswer((_) async => null);
      // Act
      await localDataSource.delete(appSettingModel);
      final result = await localDataSource.getSettings();
      // Assert
      expect(result, equals([]));
    });
  });
}
