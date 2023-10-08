import 'package:dio/dio.dart';
import 'package:flutter_starter_app/core/providers/request_provider.dart';
import 'package:flutter_starter_app/features/main/data/datasources/app_setting_remote_data_source.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_setting_remote_data_source_test.mocks.dart';

@GenerateMocks([RequestProvider])
void main() {
  group('AppSettingRemoteDataSourceImpl', () {
    late AppSettingRemoteDataSourceImpl dataSource;
    late MockRequestProvider mockRequestProvider;

    setUp(() {
      mockRequestProvider = MockRequestProvider();
      dataSource =
          AppSettingRemoteDataSourceImpl(requestProvider: mockRequestProvider);
    });

    group('getSettings', () {
      final List mockResponse = [
        {'key': 'setting1', 'value': 'value1'},
        {'key': 'setting2', 'value': 'value2'},
      ];

      test(
          'should return a list of AppSettingModel when the request is successful',
          () async {
        // Arrange
        when(mockRequestProvider.get("/")).thenAnswer((_) async =>
            Response<dynamic>(
                data: mockResponse, requestOptions: RequestOptions()));

        // Act
        final result = await dataSource.getSettings();

        // Assert
        expect(result, isA<List<AppSettingModel>>());
        expect(
            result.length, equals(2)); // Adjust based on your mockResponse data
      });

      test('should throw an exception when the request fails', () {
        // Arrange
        when(mockRequestProvider.get("/")).thenThrow(Exception("Failed"));

        // Act and Assert
        expect(() => dataSource.getSettings(), throwsA(isA<Exception>()));
      });
    });

    group('getSetting', () {
      const settingIdentifier = 'setting1';
      final mockResponse = {'key': 'setting1', 'value': 'value1'};

      test('should return an AppSettingModel when the request is successful',
          () async {
        // Arrange
        when(mockRequestProvider.get("/")).thenAnswer((_) async =>
            Response(data: mockResponse, requestOptions: RequestOptions()));

        // Act
        final result = await dataSource.getSetting(settingIdentifier);

        // Assert
        expect(result, isA<AppSettingModel>());
        // Add more assertions based on your mockResponse data
      });
    });
  });
}
