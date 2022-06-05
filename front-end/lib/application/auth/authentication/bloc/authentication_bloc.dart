import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/infrastructure/auth/authentication_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final SharedPreferences preferences;
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc(this.preferences, this.authenticationRepository) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {

      if (event is AuthenticationInitialEvent){
        emit(Loading());
        final res = await authenticationRepository.getLoginStatus();
        if (res){
          emit(Authenticated());
        } else {
          emit(UnAuthenticated());
        }
      }

      if (event is LoggedIn){
        emit(Loading());
        final res = await authenticationRepository.persistToken(event.token);
        emit(Authenticated());
      } 

      if (event is LoggedOut){
        emit(Loading());
        final res = await authenticationRepository.logout();
        emit(UnAuthenticated());
      }
    });
  }
}
