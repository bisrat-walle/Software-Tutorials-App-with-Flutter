// Mocks generated by Mockito 5.2.0 from annotations
// in softwaretutorials/test/presentation/bloctest/manage_user_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:bloc/bloc.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:softwaretutorials/infrastructure/local_repository/tutorial_local_repository.dart'
    as _i4;
import 'package:softwaretutorials/infrastructure/tutorials/enrollement_service.dart'
    as _i3;
import 'package:softwaretutorials/infrastructure/tutorials/tutorial_service.dart'
    as _i2;
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTutorialRepository_0 extends _i1.Fake
    implements _i2.TutorialRepository {}

class _FakeEnrollementRepository_1 extends _i1.Fake
    implements _i3.EnrollementRepository {}

class _FakeTutorialLocalRepository_2 extends _i1.Fake
    implements _i4.TutorialLocalRepository {}

class _FakeTutorialState_3 extends _i1.Fake implements _i5.TutorialState {}

/// A class which mocks [TutorialBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTutorialBloc extends _i1.Mock implements _i5.TutorialBloc {
  MockTutorialBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TutorialRepository get tutorialRepository =>
      (super.noSuchMethod(Invocation.getter(#tutorialRepository),
          returnValue: _FakeTutorialRepository_0()) as _i2.TutorialRepository);
  @override
  _i3.EnrollementRepository get enrollementRepository =>
      (super.noSuchMethod(Invocation.getter(#enrollementRepository),
              returnValue: _FakeEnrollementRepository_1())
          as _i3.EnrollementRepository);
  @override
  _i4.TutorialLocalRepository get tutorialLocalRepository =>
      (super.noSuchMethod(Invocation.getter(#tutorialLocalRepository),
              returnValue: _FakeTutorialLocalRepository_2())
          as _i4.TutorialLocalRepository);
  @override
  _i5.TutorialState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeTutorialState_3()) as _i5.TutorialState);
  @override
  _i6.Stream<_i5.TutorialState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i5.TutorialState>.empty())
          as _i6.Stream<_i5.TutorialState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i5.TutorialEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i5.TutorialEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i5.TutorialState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i5.TutorialEvent>(
          _i7.EventHandler<E, _i5.TutorialState>? handler,
          {_i7.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i7.Transition<_i5.TutorialEvent, _i5.TutorialState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void onChange(_i7.Change<_i5.TutorialState>? change) =>
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