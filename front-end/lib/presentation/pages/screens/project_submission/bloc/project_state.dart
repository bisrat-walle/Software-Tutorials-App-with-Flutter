part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  String message = "";
  Tutorial? tutorial;

  @override
  List<Object> get props => [];
}

class ProjectInitial extends ProjectState {}

class SingleTutorialLoadedState extends ProjectState {
  SingleTutorialLoadedState();
  SingleTutorialLoadedState.withMessage(String message) {
    super.message = message;
  }
}

class TutorialFetching extends ProjectState {}

class ProjectSubmissionLoading extends ProjectState {}

class ProjectSuccessfullySubmitted extends ProjectState {}

class ProjectSubmissionFailed extends ProjectState {}
