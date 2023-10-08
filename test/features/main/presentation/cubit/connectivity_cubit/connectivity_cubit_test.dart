import 'package:dartz/dartz.dart';
import 'package:flutter_starter_app/core/usescases/usecases.dart';
import 'package:flutter_starter_app/features/main/domain/usecases/app_setting_usecase.dart';
import 'package:flutter_starter_app/features/main/presentation/cubit/connectivity_cubit/connectivity_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../app_cubit/app_cubit_test.mocks.dart';

@GenerateMocks([AppSettingUseCase])
void main() {
  late ConnectivityCubit connectivityCubit;
  late MockAppSettingUseCase mockSettingUseCase;

  setUp(() {
    mockSettingUseCase = MockAppSettingUseCase();
    connectivityCubit = ConnectivityCubit(settingUseCase: mockSettingUseCase);
  });

  test('Initial state should be ConnectivityInitial', () {
    expect(connectivityCubit.state, equals(ConnectivityInitial()));
  });

  test('getConnectivityStream should emit ConnectivitySuccess when successful',
      () async {
    // arrange
    when(mockSettingUseCase.getStreamConnectivity(NoParams()))
        .thenAnswer((_) async => Right(Stream.value(true)));

    // act
    connectivityCubit.getConnectivityStream();

    // assert
    await expectLater(
      connectivityCubit.stream,
      emitsInOrder([
        const ConnectivitySuccess(displayMessage: true)
      ]), // Assurez-vous que la valeur est correcte
    );
  });

  test('getConnectivity should emit ConnectivitySuccess when successful',
      () async {
    // arrange
    when(mockSettingUseCase.getConnectivity(NoParams()))
        .thenAnswer((_) async => const Right(true));

    // act
    connectivityCubit.getConnectivity();

    // assert
    await expectLater(
      connectivityCubit.stream,
      emitsInOrder([const ConnectivitySuccess()]),
    );
  });
}
