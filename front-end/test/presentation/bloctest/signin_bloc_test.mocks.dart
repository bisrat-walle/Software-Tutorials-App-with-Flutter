// Mocks generated by Mockito 5.2.0 from annotations
// in softwaretutorials/test/presentation/bloctest/signin_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart'
    as _i2;
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeAuthenticationBloc_0 extends _i1.Fake
    implements _i2.AuthenticationBloc {}

class _FakeNavigationState_1 extends _i1.Fake implements _i3.NavigationState {}

/// A class which mocks [NavigationBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationBloc extends _i1.Mock implements _i3.NavigationBloc {
  MockNavigationBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AuthenticationBloc get authenticationBloc =>
      (super.noSuchMethod(Invocation.getter(#authenticationBloc),
          returnValue: _FakeAuthenticationBloc_0()) as _i2.AuthenticationBloc);
  @override
  _i3.NavigationState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeNavigationState_1()) as _i3.NavigationState);
  @override
  _i4.Stream<_i3.NavigationState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.NavigationState>.empty())
          as _i4.Stream<_i3.NavigationState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i3.NavigationEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.NavigationEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i3.NavigationState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.NavigationEvent>(
          _i5.EventHandler<E, _i3.NavigationState>? handler,
          {_i5.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i5.Transition<_i3.NavigationEvent, _i3.NavigationState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void onChange(_i5.Change<_i3.NavigationState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}
