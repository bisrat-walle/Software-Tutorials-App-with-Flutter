part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfileEvent extends UpdateProfileEvent {}

class AttemptProfileUpdateEvent extends UpdateProfileEvent {
  final fullName;
  final email;
  final username;
  final password;

  AttemptProfileUpdateEvent(
      {this.fullName, this.email, this.username, this.password});
}
