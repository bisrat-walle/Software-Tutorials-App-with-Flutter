import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwaretutorials/domain/auth/repo_response.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<LoadUserProfileEvent>((event, emit) async {
      emit(UserProfileLoadingState());
      final user = await ProfileRepository.getUserProfile();
      if (user != null){
        emit(UserProfileLoadedState(user));
      } else {
        emit(UpdateProfileErrorState("Unable to fetch user profile"));
      }
    },);
        on<AttemptProfileUpdateEvent>((event, emit) async {
      emit(UpdateProfileLoadingState());
      final RepoResponse res = await ProfileRepository.updateProfile(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        username: event.username,

      );
      if (res.success){
        emit(UpdateProfileCompletedState());
      } else {
        emit(UpdateProfileErrorState(res.error));
      }
    });
  }
}
