part of 'authentication_bloc.dart';

abstract class AuthenticationState  {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}

class Loading extends AuthenticationState {}
