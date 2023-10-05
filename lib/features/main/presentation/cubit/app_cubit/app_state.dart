// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: overridden_fields

part of 'app_cubit.dart';

class AppState extends Equatable {
  final Device? device;

  const AppState({
    this.device,
  });

  AppState copyWith({
    Device? device,
  }) {
    return AppState(
      device: device ?? this.device,
    );
  }

  @override
  List<Object?> get props => [
        device,
      ];
  @override
  String toString() {
    return '''AppState {
      device: $device,
    }''';
  }
}

class AppInitial extends AppState {}

class AppError extends AppState {
  final String? errorMessage;
  const AppError({this.errorMessage});
}
