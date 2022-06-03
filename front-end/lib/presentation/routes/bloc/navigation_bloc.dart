import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwaretutorials/presentation/core/authentication/bloc/authentication_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState>{
  final AuthenticationBloc authenticationBloc;
  NavigationBloc(this.authenticationBloc) : super(NavigationInitial()) {
    on<NavigationInitialEvent>(
        (event, emit) async {
          emit(SplashState());
        await Future.delayed(const Duration(seconds: 2));
        if (authenticationBloc.state is Authenticated){
          emit(AllTutorialsPage());
        } else {
          emit(SigninPage());
        }
        },

    );
    on<GotoSignin>(
      (event, emit) {
        emit(SigninPage());
      },
    );
    on<GotoSignup>(
      (event, emit) {
        emit(SignupPage());
      },
    );
    on<GotoAllTutorials>(
      (event, emit) {
        emit(AllTutorialsPage());
      },
    );
    on<GotoMyTutorials>(
      (event, emit){
        emit(MyTutorialsPage());
    });
    on<GotoEnrolledTutorials>(
      (event, emit){
        emit(EnrolledTutorialsPage());
    });
  }
}
