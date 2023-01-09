part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  final tutorialId;
  String message = "";
  ProjectEvent(this.tutorialId);

  @override
  List<Object> get props => [];
}

class LoadTutorialEvent extends ProjectEvent {
  LoadTutorialEvent(tutorialId) : super(tutorialId);
  factory LoadTutorialEvent.withMessage(tutorialId, String message) {
    final state = LoadTutorialEvent(tutorialId);
    state.message = message;
    return state;
  }
}

class ProjectCreation extends ProjectEvent {
  final projectUrl;

  ProjectCreation(int tutorialId, this.projectUrl) : super(tutorialId);
}

class ToggleEditEvent extends ProjectEvent {
  ToggleEditEvent(tutorialId) : super(tutorialId);
}

class ProjectUpdate extends ProjectEvent {
  final projectUrl;

  ProjectUpdate(int tutorialId, this.projectUrl) : super(tutorialId);
}

class ProjectDelete extends ProjectEvent {
  ProjectDelete(int tutorialId) : super(tutorialId);
}
