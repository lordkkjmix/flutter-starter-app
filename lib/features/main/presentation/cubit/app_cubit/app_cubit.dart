import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_app/core/usescases/usecases.dart';
import 'package:flutter_starter_app/features/main/domain/entities/device.dart';
import 'package:flutter_starter_app/features/main/domain/usecases/app_setting_usecase.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppSettingUseCase _settingUseCase;
  AppCubit({
    required AppSettingUseCase settingUseCase,
  })  : _settingUseCase = settingUseCase,
        super(AppInitial());

  initializeApp() {
    getDevice();
  }

  getDevice() async {
    final failedOrDevice = await _settingUseCase(NoParams());
    failedOrDevice.fold(
        ((l) => emit(AppError(errorMessage: l.message.toString()))),
        (r) => emit(state.copyWith(device: r)));
  }
}
