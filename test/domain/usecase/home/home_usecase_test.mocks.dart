// Mocks generated by Mockito 5.3.0 from annotations
// in fluttour/test/domain/usecase/home/home_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:connectivity/connectivity.dart' as _i3;
import 'package:dartz/dartz.dart' as _i4;
import 'package:fluttour/data/api/error/error.dart' as _i7;
import 'package:fluttour/data/api/response/fluttour_response.dart' as _i8;
import 'package:fluttour/data/datasource/home/home_datasource_type.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

import 'home_usecase_test.dart' as _i5;

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

class _FakeHomeDataSourceType_0 extends _i1.SmartFake
    implements _i2.HomeDataSourceType {
  _FakeHomeDataSourceType_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeConnectivity_1 extends _i1.SmartFake implements _i3.Connectivity {
  _FakeConnectivity_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [MockHomeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockHomeRepository extends _i1.Mock
    implements _i5.MockHomeRepository {
  MockMockHomeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.HomeDataSourceType get dataSource => (super.noSuchMethod(
          Invocation.getter(#dataSource),
          returnValue:
              _FakeHomeDataSourceType_0(this, Invocation.getter(#dataSource)))
      as _i2.HomeDataSourceType);
  @override
  _i3.Connectivity get connectivity =>
      (super.noSuchMethod(Invocation.getter(#connectivity),
              returnValue:
                  _FakeConnectivity_1(this, Invocation.getter(#connectivity)))
          as _i3.Connectivity);
  @override
  _i6.Future<_i4.Either<_i7.Failure, _i8.FluttourResponse>>
      getFluttourDoctor() => (super.noSuchMethod(
          Invocation.method(#getFluttourDoctor, []),
          returnValue:
              _i6.Future<_i4.Either<_i7.Failure, _i8.FluttourResponse>>.value(
                  _FakeEither_2<_i7.Failure, _i8.FluttourResponse>(
                      this, Invocation.method(#getFluttourDoctor, [])))) as _i6
          .Future<_i4.Either<_i7.Failure, _i8.FluttourResponse>>);
  @override
  _i6.Future<bool> isInConnection() =>
      (super.noSuchMethod(Invocation.method(#isInConnection, []),
          returnValue: _i6.Future<bool>.value(false)) as _i6.Future<bool>);
}
