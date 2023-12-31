// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_starter_app/test/features/main/presentation/cubit/app_cubit/app_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:flutter_starter_app/core/errors/failures.dart' as _i6;
import 'package:flutter_starter_app/core/usescases/usecases.dart' as _i8;
import 'package:flutter_starter_app/features/main/domain/entities/app_setting.dart'
    as _i9;
import 'package:flutter_starter_app/features/main/domain/entities/device.dart'
    as _i7;
import 'package:flutter_starter_app/features/main/domain/repositories/app_setting_repository.dart'
    as _i2;
import 'package:flutter_starter_app/features/main/domain/usecases/app_setting_usecase.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAppSettingRepository_0 extends _i1.SmartFake
    implements _i2.AppSettingRepository {
  _FakeAppSettingRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AppSettingUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppSettingUseCase extends _i1.Mock implements _i4.AppSettingUseCase {
  MockAppSettingUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppSettingRepository get appSettingRepository => (super.noSuchMethod(
        Invocation.getter(#appSettingRepository),
        returnValue: _FakeAppSettingRepository_0(
          this,
          Invocation.getter(#appSettingRepository),
        ),
      ) as _i2.AppSettingRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Device>> call(_i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Device>>.value(
            _FakeEither_1<_i6.Failure, _i7.Device>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Device>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i5.Stream<bool>>> getStreamConnectivity(
          _i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getStreamConnectivity,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i5.Stream<bool>>>.value(
                _FakeEither_1<_i6.Failure, _i5.Stream<bool>>(
          this,
          Invocation.method(
            #getStreamConnectivity,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i5.Stream<bool>>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> getConnectivity(
          _i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getConnectivity,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #getConnectivity,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.AppSetting>>> getSettings(
          _i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSettings,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i9.AppSetting>>>.value(
                _FakeEither_1<_i6.Failure, List<_i9.AppSetting>>(
          this,
          Invocation.method(
            #getSettings,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i9.AppSetting>>>);
}
