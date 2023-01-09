part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class Loading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
