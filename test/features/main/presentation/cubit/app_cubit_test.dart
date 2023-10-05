import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_starter_app/core/errors/failures.dart';
import 'package:flutter_starter_app/core/usescases/usecases.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';
import 'package:flutter_starter_app/features/main/domain/entities/device.dart';
import 'package:flutter_starter_app/features/main/domain/usecases/app_setting_usecase.dart';
import 'package:flutter_starter_app/features/main/presentation/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockAppSettingUseCase extends Mock implements AppSettingUseCase {}

void main() {
  late AppCubit appCubit;
  late MockAppSettingUseCase mockSettingUseCase;
  late DeviceModel deviceModel;
  late Device deviceEntity;

  final deviceModelBody = jsonDecode(fixture('device_model.json'));
  setUp(() {
    mockSettingUseCase = MockAppSettingUseCase();
    appCubit = AppCubit(settingUseCase: mockSettingUseCase);
    deviceModel = DeviceModel.fromJson(deviceModelBody);
    deviceEntity = deviceModel;
  });

  test('Initial state should be AppInitial', () {
    expect(appCubit.state, equals(AppInitial()));
  });
  Future<Device> getDevice() async {
    return deviceEntity;
  }

  test('getDevice should emit when successful', () async {
    // arrange
    when(mockSettingUseCase(NoParams()))
        .thenAnswer((_) async => Right(deviceEntity));
    // act
    appCubit.getDevice();
    // assert
    await expectLater(
      appCubit.stream,
      emitsInOrder([appCubit.state.copyWith(device: deviceEntity)]),
    );
  });

  test('getDevice should emit AppError when there is a failure', () async {
    // Configurez le mock pour renvoyer une erreur lorsque le UseCase est appelé
    when(mockSettingUseCase(NoParams())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Some error message')));

    // Appelez la méthode getDevice
    appCubit.getDevice();

    // Attendez l'émission de l'état AppError
    await expectLater(
      appCubit.stream,
      emitsInOrder([const AppError(errorMessage: 'Some error message')]),
    );
  });
}
