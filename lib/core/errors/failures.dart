// ignore_for_file: overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? statusCode;
  final String? message;
  const Failure({this.statusCode, this.message});
  @override
  List<Object?> get props => [statusCode, message];
}

// General failures
class ServerFailure extends Failure {
  final int? statusCode;
  final String? message;
  const ServerFailure({this.statusCode, this.message});
  @override
  List<Object?> get props => [statusCode, message];
}

class CacheFailure extends Failure {}

class PermissionFailure extends Failure {}
