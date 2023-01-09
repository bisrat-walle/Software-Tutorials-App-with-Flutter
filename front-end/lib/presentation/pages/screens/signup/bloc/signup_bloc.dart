import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwaretutorials/domain/auth/repo_response.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final profileRepository;
  SignupBloc(this.profileRepository) : super(SignupInitial()) {
    on<AttemptSignupEvent>((event, emit) async {
      emit(SignupLoadingState());
      final RepoResponse res = await profileRepository.signup(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        role: event.role,
        username: event.username,
      );
      if (res.success) {
        emit(SignupCompletedState());
      } else {
        emit(SignupErrorState(res.error));
      }
    });
  }
}
