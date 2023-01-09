part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final token;

  LoggedIn(this.token);
}

class AuthenticationInitialEvent extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
