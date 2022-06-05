import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/infrastructure/auth/authentication_service.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {

  final AuthenticationBloc authenticationBloc;
  final AuthenticationRepository authenticationRepository;

  SigninBloc(this.authenticationBloc, this.authenticationRepository) : super(SigninInit()) {
    on<AttemptLoginEvent>(
      (event, emit) async {
        emit(Loading());
        final res = await authenticationRepository.authenticateUser(username:event.username, password:event.password);
        if (res){
          print("Authentication Success");
          event.navigationBloc.add(GotoAllTutorials());
        } else {
          emit(SigninError("Username or password is incorrect"));
        }
        emit(Normal());
      },
    );
    on<NormalEvent>((event, emit) async {
        emit(Loading());
        final res = await authenticationRepository.getLoginStatus();
        if (res){
          emit(Loading());
          emit(SigninSuccess());
        } else {
          emit(Normal());
        }
    });
  }
}
