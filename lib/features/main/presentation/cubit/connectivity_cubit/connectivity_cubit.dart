import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_starter_app/core/usescases/usecases.dart';
import 'package:flutter_starter_app/features/main/domain/usecases/app_setting_usecase.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final AppSettingUseCase _settingUseCase;
  ConnectivityCubit({
    required AppSettingUseCase settingUseCase,
  })  : _settingUseCase = settingUseCase,
        super(ConnectivityInitial());

  getConnectivityStream() async {
    final eitherFailureOrDeviceConnectivity =
        await _settingUseCase.getStreamConnectivity(NoParams());
    eitherFailureOrDeviceConnectivity.fold(
        (l) => emit(ConnectivityInProgress()),
        (connectivity) => connectivity.listen((bool result) async {
              if (result) {
                emit(ConnectivitySuccess(
                    displayMessage:
                        state is ConnectivitySuccess ? false : true));
              } else {
                emit(ConnectivityFailure(
                    displayMessage:
                        state is ConnectivitySuccess ? false : true));
              }
            }, onError: (error) => emit(const ConnectivityFailure())));
  }

  getConnectivity() async {
    emit(ConnectivityInProgress());
    final eitherFailureOrLoadSettings = //fetch server config
        await _settingUseCase.getConnectivity(NoParams());
    eitherFailureOrLoadSettings.fold(
      (l) => emit(const ConnectivityFailure(displayMessage: true)),
      (connectivity) async {
        if (!connectivity) {
          emit(const ConnectivityFailure(displayMessage: true));
        } else {
          emit(const ConnectivitySuccess());
        }
      },
    );
  }
}
