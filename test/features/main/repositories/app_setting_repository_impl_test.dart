import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_starter_app/core/errors/failures.dart';
import 'package:flutter_starter_app/core/providers/network_provider.dart';
import 'package:flutter_starter_app/features/main/data/datasources/app_setting_local_data_source.dart';
import 'package:flutter_starter_app/features/main/data/datasources/app_setting_remote_data_source.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';
import 'package:flutter_starter_app/features/main/data/repositories/app_setting_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'app_setting_repository_impl_test.mocks.dart';

@GenerateMocks(
    [NetworkProvider, AppSettingLocalDataSource, AppSettingRemoteDataSource])
void main() {
  late AppSettingRepositoryImpl repository;
  late MockAppSettingLocalDataSource mockLocalDataSource;
  late MockAppSettingRemoteDataSource mockRemoteDataSource;
  late MockNetworkProvider mockNetworkProvider;
  late AppSettingModel appSettingModel;
  late DeviceModel deviceModel;
  final deviceModelBody = jsonDecode(fixture('device_model.json'));
  final appSettingModelBody = jsonDecode(fixture('app_setting_model.json'));
  appSettingModel = AppSettingModel.fromJson(appSettingModelBody);

  setUp(() {
    mockLocalDataSource = MockAppSettingLocalDataSource();
    mockRemoteDataSource = MockAppSettingRemoteDataSource();
    mockNetworkProvider = MockNetworkProvider();
    repository = AppSettingRepositoryImpl(
      appSettingLocalDataSource: mockLocalDataSource,
      appSettingRemoteDataSource: mockRemoteDataSource,
      networkProvider: mockNetworkProvider,
    );
    deviceModel = DeviceModel.fromJson(deviceModelBody);
    appSettingModel = AppSettingModel.fromJson(appSettingModelBody);
  });

  group('getStreamConnectivity', () {
    test('should return a Stream of Right(bool)', () async {
      // Arrange
      final streamController = StreamController<bool>();
      when(mockNetworkProvider.onConnectivityChanged)
          .thenAnswer((_) => streamController.stream);

      // Act
      final result = await repository.getStreamConnectivity();

      // Assert
      expect(result, isA<Right<Failure, Stream<bool>>>());
      expect(result.getOrElse(() => throw Exception()), isA<Stream<bool>>());

      // Clean up
      streamController.close();
    });

    test('should return a Left(ServerFailure) when an exception occurs',
        () async {
      // Arrange
      when(mockNetworkProvider.onConnectivityChanged)
          .thenThrow(Exception("Failed"));

      // Act
      final result = await repository.getStreamConnectivity();

      // Assert
      expect(
          result, const Left(ServerFailure(statusCode: -1, message: 'Failed')));
    });
  });

  group('getDeviceInfo', () {
    test('should return Right(Device) when successful', () async {
      // Arrange
      final device = deviceModel;
      when(mockLocalDataSource.getDevice()).thenAnswer((_) async => device);

      // Act
      final result = await repository.getDeviceInfo();

      // Assert
      expect(result, Right(device));
    });

    test('should return Left(ServerFailure) when an exception occurs',
        () async {
      // Arrange
      when(mockLocalDataSource.getDevice()).thenThrow(Exception("Failed"));

      // Act
      final result = await repository.getDeviceInfo();

      // Assert
      expect(
          result, const Left(ServerFailure(statusCode: -1, message: 'Failed')));
    });
  });

  group('getSettings', () {
    test('should return Right(List<AppSetting>) when successful', () async {
      // Arrange
      final settings = [appSettingModel];
      when(mockRemoteDataSource.getSettings())
          .thenAnswer((_) async => settings);

      // Act
      final result = await repository.getSettings();

      // Assert
      expect(result, Right(settings));
    });

    test('should return Left(ServerFailure) when an exception occurs',
        () async {
      // Arrange
      when(mockRemoteDataSource.getSettings()).thenThrow(Exception("Failed"));

      // Act
      final result = await repository.getSettings();

      // Assert
      expect(
          result, const Left(ServerFailure(statusCode: -1, message: 'Failed')));
    });
  });

  group('writeSetting', () {
    test('should return Right(void) when successful', () async {
      // Arrange
      final setting = appSettingModel;

      // Act
      final result = await repository.writeSetting(setting: setting);

      // Assert
      expect(result, const Right(null));
    });

    test('should return Left(ServerFailure) when an exception occurs',
        () async {
      // Arrange
      when(mockLocalDataSource.writeSetting(appSettingModel))
          .thenThrow(Exception("Failed"));

      // Act
      final result = await repository.writeSetting(setting: appSettingModel);

      // Assert
      expect(
          result, const Left(ServerFailure(statusCode: -1, message: 'Failed')));
    });
  });
}
