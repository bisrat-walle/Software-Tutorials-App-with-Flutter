part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();
}

class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadedState extends UpdateProfileState {
  final User user;

  @override
  List<Object?> get props => [];

  UserProfileLoadedState(this.user);
}

class UserProfileLoadingState extends UpdateProfileState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileErrorState extends UpdateProfileState {
  @override
  List<Object?> get props => [];
  final error;

  UpdateProfileErrorState(this.error);
}

class UpdateProfileLoadingState extends UpdateProfileState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileCompletedState extends UpdateProfileState {
  @override
  List<Object?> get props => [];
}
