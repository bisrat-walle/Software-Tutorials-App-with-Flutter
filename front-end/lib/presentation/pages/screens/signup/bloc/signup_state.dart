part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupErrorState extends SignupState {
  final error;

  SignupErrorState(this.error);
}

class SignupLoadingState extends SignupState {}

class SignupCompletedState extends SignupState {}
