part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();
}

class SigninInit extends SigninState {
  @override
  List<Object?> get props => [];
}

class Normal extends SigninState {
  @override
  List<Object?> get props => [];
}

class SigninSuccess extends SigninState {
  @override
  List<Object?> get props => [];
}

class Loading extends SigninState {
  @override
  List<Object?> get props => [];
}

class SigninError extends SigninState {
  final error;
  SigninError(this.error);

  @override
  List<Object?> get props => [];
}
