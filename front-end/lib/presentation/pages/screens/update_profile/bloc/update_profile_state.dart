part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();
  
  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UserProfileLoadedState extends UpdateProfileState {
  final User user;

  UserProfileLoadedState(this.user);
}

class UserProfileLoadingState extends UpdateProfileState {}

class UpdateProfileErrorState extends UpdateProfileState {
  final error;

  UpdateProfileErrorState(this.error);
}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UpdateProfileCompletedState extends UpdateProfileState {}