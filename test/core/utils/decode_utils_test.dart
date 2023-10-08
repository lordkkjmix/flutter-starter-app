import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_starter_app/core/errors/exceptions.dart';
import 'package:flutter_starter_app/core/errors/failures.dart';
import 'package:flutter_starter_app/core/utils/decode_utils.dart';
import 'package:flutter_starter_app/features/main/data/models/app_setting_model.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';
import 'package:flutter_starter_app/features/main/domain/entities/app_setting.dart';
import 'package:flutter_starter_app/features/main/domain/entities/device.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final deviceModelBody = jsonDecode(fixture('device_model.json'));

  group('decodeDataSourceResponse', () {
    test('should decode a List<dynamic> response', () {
      final response = [deviceModelBody, deviceModelBody];

      final decodedData = decodeDataSourceResponse(response,
          decoder: (item) => DeviceModel.fromJson(item));

      expect(decodedData, isA<List<DeviceModel>>());
      expect(decodedData.length, equals(2));
    });

    test('should decode a Map<String, dynamic> response', () {
      final response = {'id': 1, 'name': 'Item 1'};

      final decodedData = decodeDataSourceResponse(response, decoder: (item) {
        return DeviceModel.fromJson(
            item); // Replace with your data model constructor
      });

      expect(decodedData, isA<dynamic>());
    });
  });

  group('implementRepository', () {
    test('should return Right result when implementation succeeds', () async {
      final implementation =
          Future.value(DeviceModel); // Replace with your data type

      final result = await implementRepository(implementation);

      expect(result, isA<Right<Failure, dynamic>>());
    });

    test('should return Left ServerFailure when implementation fails',
        () async {
      final implementation = Future<AppSetting>.error(const RequestException(
        statusCode: 500,
        message: 'Internal Server Error',
      ));

      final result = await implementRepository<AppSetting>(implementation);

      expect(result, isA<Left<Failure, AppSetting>>());
      expect(
        result.fold((failure) => failure, (_) => null),
        isA<ServerFailure>(),
      );
    });
  });
}
