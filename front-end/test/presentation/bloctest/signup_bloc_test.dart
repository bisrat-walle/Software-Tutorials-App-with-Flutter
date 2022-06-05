import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/domain/auth/repo_response.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/presentation/pages/screens/signup/bloc/signup_bloc.dart';
import 'package:test/test.dart';

import 'tutorial_bloc_test.mocks.dart';

final User user = User(id: 1, email: "b@b.com", fullName: "name", 
  password: "skjfd", role: "CLIENT", username: "username");

void main() {
  final mockProfileRepository = MockProfileRepository();
   group('SigninBloc', () {
	
	blocTest<SignupBloc, SignupState>(
      'emits [SignupLoadingState(), SignupCompletedState()] when AttemptSignupEvent is added and becomes successfull',
     setUp:() {
       when(mockProfileRepository.signup(
        email: user.email,
        password: user.password,
        fullName: user.fullName,
        role: user.role,
        username: user.username,

      )).thenAnswer((_) => Future.value(RepoResponse(true)));
     },
      build: () => SignupBloc(mockProfileRepository)..add(AttemptSignupEvent(
				fullName:user.fullName!, username:user.username!, email:user.email!, 
				password:user.password!, role:user.role!)),
      expect: () => [SignupLoadingState(), SignupCompletedState()],
    );
	
	blocTest<SignupBloc, SignupState>(
      'emits [SignupLoadingState(), SignupCompletedState()] when AttemptSignupEvent is added and becomes successfull',
     setUp:() {
       when(mockProfileRepository.signup(
        email: user.email,
        password: user.password,
        fullName: user.fullName,
        role: user.role,
        username: user.username,

      )).thenAnswer((_) => Future.value(RepoResponse(true)));
     },
      build: () => SignupBloc(mockProfileRepository)..add(AttemptSignupEvent(
				fullName:user.fullName!, username:user.username!, email:user.email!, 
				password:user.password!, role:user.role!)),
      expect: () => [SignupLoadingState(), SignupCompletedState()],
    );
	
	blocTest<SignupBloc, SignupState>(
      'emits [SignupLoadingState(), SignupCompletedState()] when AttemptSignupEvent is added and failes',
     setUp:() {
       when(mockProfileRepository.signup(
        email: user.email,
        password: user.password,
        fullName: user.fullName,
        role: user.role,
        username: user.username,

      )).thenAnswer((_) => Future.value(RepoResponse(false, error:"error")));
     },
      build: () => SignupBloc(mockProfileRepository)..add(AttemptSignupEvent(
				fullName:user.fullName!, username:user.username!, email:user.email!, 
				password:user.password!, role:user.role!)),
      expect: () => [SignupLoadingState(), SignupErrorState("error")],
    );
});
}

