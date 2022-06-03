part of 'manageuser_bloc.dart';

abstract class ManageuserEvent extends Equatable {
  const ManageuserEvent();

  @override
  List<Object> get props => [];
}

class GotoManageUserScreenEvent extends ManageuserEvent {}
class DeleteUserEvent extends ManageuserEvent {}
