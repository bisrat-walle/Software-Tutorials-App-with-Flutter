part of 'manageuser_bloc.dart';

abstract class ManageuserState extends Equatable {
  ManageuserState();

  List<User> userList = [];

  @override
  List<Object> get props => [];
}

class ManageuserInitial extends ManageuserState {}

class ManageuserLoading extends ManageuserState {}

class ManageUserLoading extends ManageuserState {}

class ManageuserLoaded extends ManageuserState {
  final List<User> userList;

  ManageuserLoaded(this.userList);

  @override
  List<Object> get props => [userList];
}

class ManageUserScreenState extends ManageuserState {
  ManageUserScreenState();
}

class DeleteUserSuccessState extends ManageuserState {}

class DeleteUserFailureState extends ManageuserState {
  late final error;
  DeleteUserFailureState(this.error);
}
