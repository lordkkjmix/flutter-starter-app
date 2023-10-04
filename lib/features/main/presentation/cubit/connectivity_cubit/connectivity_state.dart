part of 'connectivity_cubit.dart';

abstract class ConnectivityState extends Equatable {
  final bool displayMessage;
  const ConnectivityState({this.displayMessage = false});

  @override
  List<Object?> get props => [displayMessage];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityInProgress extends ConnectivityState {}

class ConnectivitySuccess extends ConnectivityState {
  @override
  final bool displayMessage;
  const ConnectivitySuccess({this.displayMessage = false});
}

class ConnectivityFailure extends ConnectivityState {
  @override
  final bool displayMessage;
  const ConnectivityFailure({this.displayMessage = false});
}
