import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/presentation/pages/screens/update_profile/bloc/update_profile_bloc.dart';
import 'package:test/test.dart';

import 'tutorial_bloc_test.mocks.dart';

final User user = User(id: 1, email: "b@b.com", fullName: "name", 
  password: "skjfd", role: "CLIENT", username: "username");

void main() {
  final mockProfileRepository = MockProfileRepository();
   group('UpdateProfileBloc', () {
	blocTest<UpdateProfileBloc, UpdateProfileState>(
      'emits [UserProfileLoadingState(), UserProfileLoadedState(user)] when LoadUserProfileEvent is added and becomes successfull',
     setUp:() {
       when(mockProfileRepository.getUserProfile()).thenAnswer((_) => Future.value(user));
     },
      build: () => UpdateProfileBloc(mockProfileRepository)..add(LoadUserProfileEvent()),
      expect: () => [UserProfileLoadingState(), UserProfileLoadedState(user)],
    );
	
	blocTest<UpdateProfileBloc, UpdateProfileState>(
      'emits [UserProfileLoadingState(), UpdateProfileErrorState()] when LoadUserProfileEvent is added and fails',
     setUp:() {
       when(mockProfileRepository.getUserProfile()).thenAnswer((_) => Future.value(null));
     },
      build: () => UpdateProfileBloc(mockProfileRepository)..add(LoadUserProfileEvent()),
      expect: () => [UserProfileLoadingState(), UpdateProfileErrorState("Unable to fetch user profile")],
    );
	
});
}

