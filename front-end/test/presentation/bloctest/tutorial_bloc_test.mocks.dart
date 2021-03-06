// Mocks generated by Mockito 5.2.0 from annotations
// in softwaretutorials/test/presentation/bloctest/tutorial_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;

import 'package:mockito/mockito.dart' as _i1;
import 'package:softwaretutorials/domain/auth/repo_response.dart' as _i3;
import 'package:softwaretutorials/domain/core/models.dart' as _i6;
import 'package:softwaretutorials/infrastructure/local_repository/local_data_provider.dart'
    as _i5;
import 'package:softwaretutorials/infrastructure/local_repository/tutorial_local_repository.dart'
    as _i4;
import 'package:softwaretutorials/infrastructure/local_repository/user_local_repository.dart'
    as _i2;
import 'package:softwaretutorials/infrastructure/tutorials/enrollement_service.dart'
    as _i9;
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart'
    as _i7;
import 'package:softwaretutorials/infrastructure/tutorials/tutorial_service.dart'
    as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUserLocalRepository_0 extends _i1.Fake
    implements _i2.UserLocalRepository {}

class _FakeRepoResponse_1 extends _i1.Fake implements _i3.RepoResponse {}

class _FakeTutorialLocalRepository_2 extends _i1.Fake
    implements _i4.TutorialLocalRepository {}

class _FakeLocalDataProvider_3 extends _i1.Fake
    implements _i5.LocalDataProvider {}

class _FakeTutorial_4 extends _i1.Fake implements _i6.Tutorial {}

/// A class which mocks [ProfileRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileRepository extends _i1.Mock implements _i7.ProfileRepository {
  MockProfileRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserLocalRepository get userLocalRepository => (super.noSuchMethod(
      Invocation.getter(#userLocalRepository),
      returnValue: _FakeUserLocalRepository_0()) as _i2.UserLocalRepository);
  @override
  _i8.Future<_i3.RepoResponse> signup(
          {String? email,
          String? username,
          dynamic fullName,
          String? password,
          String? role}) =>
      (super.noSuchMethod(
              Invocation.method(#signup, [], {
                #email: email,
                #username: username,
                #fullName: fullName,
                #password: password,
                #role: role
              }),
              returnValue:
                  Future<_i3.RepoResponse>.value(_FakeRepoResponse_1()))
          as _i8.Future<_i3.RepoResponse>);
  @override
  _i8.Future<_i3.RepoResponse> updateProfile(
          {String? email,
          String? username,
          dynamic fullName,
          String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#updateProfile, [], {
                #email: email,
                #username: username,
                #fullName: fullName,
                #password: password
              }),
              returnValue:
                  Future<_i3.RepoResponse>.value(_FakeRepoResponse_1()))
          as _i8.Future<_i3.RepoResponse>);
  @override
  _i8.Future<List<_i6.User>> getAllUsers() =>
      (super.noSuchMethod(Invocation.method(#getAllUsers, []),
              returnValue: Future<List<_i6.User>>.value(<_i6.User>[]))
          as _i8.Future<List<_i6.User>>);
  @override
  _i8.Future<bool> deleteUser(String? username) =>
      (super.noSuchMethod(Invocation.method(#deleteUser, [username]),
          returnValue: Future<bool>.value(false)) as _i8.Future<bool>);
  @override
  _i8.Future<_i6.User?> getUserProfile() =>
      (super.noSuchMethod(Invocation.method(#getUserProfile, []),
          returnValue: Future<_i6.User?>.value()) as _i8.Future<_i6.User?>);
}

/// A class which mocks [EnrollementRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockEnrollementRepository extends _i1.Mock
    implements _i9.EnrollementRepository {
  MockEnrollementRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TutorialLocalRepository get tutorialLocalRepository =>
      (super.noSuchMethod(Invocation.getter(#tutorialLocalRepository),
              returnValue: _FakeTutorialLocalRepository_2())
          as _i4.TutorialLocalRepository);
  @override
  _i8.Future<String?> enroll({int? tutorialId}) => (super.noSuchMethod(
      Invocation.method(#enroll, [], {#tutorialId: tutorialId}),
      returnValue: Future<String?>.value()) as _i8.Future<String?>);
  @override
  _i8.Future<String?> unenroll({int? tutorialId}) => (super.noSuchMethod(
      Invocation.method(#unenroll, [], {#tutorialId: tutorialId}),
      returnValue: Future<String?>.value()) as _i8.Future<String?>);
}

/// A class which mocks [TutorialRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTutorialRepository extends _i1.Mock
    implements _i10.TutorialRepository {
  MockTutorialRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TutorialLocalRepository get tutorialLocalRepository =>
      (super.noSuchMethod(Invocation.getter(#tutorialLocalRepository),
              returnValue: _FakeTutorialLocalRepository_2())
          as _i4.TutorialLocalRepository);
  @override
  set tutorialLocalRepository(
          _i4.TutorialLocalRepository? _tutorialLocalRepository) =>
      super.noSuchMethod(
          Invocation.setter(#tutorialLocalRepository, _tutorialLocalRepository),
          returnValueForMissingStub: null);
  @override
  _i8.Future<List<_i6.Tutorial>> getAllTutorials() =>
      (super.noSuchMethod(Invocation.method(#getAllTutorials, []),
              returnValue: Future<List<_i6.Tutorial>>.value(<_i6.Tutorial>[]))
          as _i8.Future<List<_i6.Tutorial>>);
  @override
  _i8.Future<_i6.Tutorial?> getTutorial(int? tutorialId) => (super.noSuchMethod(
      Invocation.method(#getTutorial, [tutorialId]),
      returnValue: Future<_i6.Tutorial?>.value()) as _i8.Future<_i6.Tutorial?>);
  @override
  _i8.Future<List<_i6.Tutorial>> getEnrolledTutorials() =>
      (super.noSuchMethod(Invocation.method(#getEnrolledTutorials, []),
              returnValue: Future<List<_i6.Tutorial>>.value(<_i6.Tutorial>[]))
          as _i8.Future<List<_i6.Tutorial>>);
  @override
  _i8.Future<List<_i6.Tutorial>> getMyTutorials() =>
      (super.noSuchMethod(Invocation.method(#getMyTutorials, []),
              returnValue: Future<List<_i6.Tutorial>>.value(<_i6.Tutorial>[]))
          as _i8.Future<List<_i6.Tutorial>>);
  @override
  _i8.Future<bool> createTutorial(
          {String? title,
          String? content,
          String? projectTitle,
          String? problemStatement}) =>
      (super.noSuchMethod(
          Invocation.method(#createTutorial, [], {
            #title: title,
            #content: content,
            #projectTitle: projectTitle,
            #problemStatement: problemStatement
          }),
          returnValue: Future<bool>.value(false)) as _i8.Future<bool>);
  @override
  _i8.Future<bool> updateTutorial(
          {String? title,
          String? content,
          String? projectTitle,
          String? problemStatement,
          int? tutorialId}) =>
      (super.noSuchMethod(
          Invocation.method(#updateTutorial, [], {
            #title: title,
            #content: content,
            #projectTitle: projectTitle,
            #problemStatement: problemStatement,
            #tutorialId: tutorialId
          }),
          returnValue: Future<bool>.value(false)) as _i8.Future<bool>);
  @override
  _i8.Future<bool> deleteTutorial({int? tutorialId}) => (super.noSuchMethod(
      Invocation.method(#deleteTutorial, [], {#tutorialId: tutorialId}),
      returnValue: Future<bool>.value(false)) as _i8.Future<bool>);
}

/// A class which mocks [TutorialLocalRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTutorialLocalRepository extends _i1.Mock
    implements _i4.TutorialLocalRepository {
  MockTutorialLocalRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.LocalDataProvider get dbProvider =>
      (super.noSuchMethod(Invocation.getter(#dbProvider),
          returnValue: _FakeLocalDataProvider_3()) as _i5.LocalDataProvider);
  @override
  _i8.Future<int> createTutorial(_i6.Tutorial? tutorial) =>
      (super.noSuchMethod(Invocation.method(#createTutorial, [tutorial]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<List<_i6.Tutorial>> getAllTutorials() =>
      (super.noSuchMethod(Invocation.method(#getAllTutorials, []),
              returnValue: Future<List<_i6.Tutorial>>.value(<_i6.Tutorial>[]))
          as _i8.Future<List<_i6.Tutorial>>);
  @override
  _i8.Future<int> updateTutorial(_i6.Tutorial? tutorial) =>
      (super.noSuchMethod(Invocation.method(#updateTutorial, [tutorial]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> toggleEnrollement(_i6.Tutorial? tutorial) =>
      (super.noSuchMethod(Invocation.method(#toggleEnrollement, [tutorial]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> submitProject(_i6.Tutorial? tutorial) =>
      (super.noSuchMethod(Invocation.method(#submitProject, [tutorial]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> deleteTutorial(int? tutorialId) =>
      (super.noSuchMethod(Invocation.method(#deleteTutorial, [tutorialId]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<_i6.Tutorial> getTutorial(int? tutorialId) =>
      (super.noSuchMethod(Invocation.method(#getTutorial, [tutorialId]),
              returnValue: Future<_i6.Tutorial>.value(_FakeTutorial_4()))
          as _i8.Future<_i6.Tutorial>);
  @override
  _i8.Future<int> removeTables() =>
      (super.noSuchMethod(Invocation.method(#removeTables, []),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
}
