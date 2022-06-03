part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class NormalEvent extends SigninEvent {}

class AttemptLoginEvent extends SigninEvent {
  final username;
  final password;
  final NavigationBloc navigationBloc;
  AttemptLoginEvent(this.username, this.password, this.navigationBloc);

}

