part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class AttemptSignupEvent extends SignupEvent {
  final fullName;
  final email;
  final username;
  final password;
  final role;

  AttemptSignupEvent({this.fullName, this.email, this.username, this.password, this.role});
}