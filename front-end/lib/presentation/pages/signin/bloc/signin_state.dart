part of 'signin_bloc.dart';

abstract class SigninState  {
  const SigninState();
  
}
class SigninInit extends SigninState{}

class Normal extends SigninState {}

class SigninSuccess extends SigninState {
}

class Loading extends SigninState {}

class SigninError extends SigninState {
  final error;
  SigninError(this.error);
}