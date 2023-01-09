part of 'tutorial_bloc.dart';

abstract class TutorialEvent extends Equatable {
  String message = "";
  int selectedTab = 0;
  TutorialEvent(this.selectedTab);

  @override
  List<Object> get props => [];
}

class GotoCreateTutorialEvent extends TutorialEvent {
  GotoCreateTutorialEvent(int selectedTab) : super(selectedTab);
}

class GotoManageUserEvent extends TutorialEvent {
  GotoManageUserEvent(int selectedTab) : super(selectedTab);
}

class GotoTutorialDetailEvent extends TutorialEvent {
  final Tutorial tutorial;

  GotoTutorialDetailEvent(this.tutorial, int selecteTab) : super(selecteTab);
}

class CreateTutorialEvent extends TutorialEvent {
  TutorialFormModel tutorialForm;
  CreateTutorialEvent(this.tutorialForm, int selecteTab) : super(selecteTab);
}

class UpdateTutorialEvent extends TutorialEvent {
  TutorialFormModel tutorialForm;
  UpdateTutorialEvent(this.tutorialForm, int selecteTab) : super(selecteTab);

  @override
  List<Object> get props => [tutorialForm];
}

class GotoUpdateTutorialEvent extends TutorialEvent {
  TutorialFormModel tutorialForm;
  GotoUpdateTutorialEvent(this.tutorialForm, int selecteTab)
      : super(selecteTab);

  @override
  List<Object> get props => [tutorialForm];
}

class LoadAllTutorials extends TutorialEvent {
  LoadAllTutorials(int selectedTab) : super(selectedTab);
}

class LoadMyTutorials extends TutorialEvent {
  LoadMyTutorials(int selectedTab) : super(selectedTab);
}

class LoadEnrolledTutorials extends TutorialEvent {
  LoadEnrolledTutorials(int selectedTab) : super(selectedTab);
}

class DeleteTutorialEvent extends TutorialEvent {
  int tutorialId;
  DeleteTutorialEvent(this.tutorialId, int selectedTab) : super(selectedTab);
}

class EnrollTutorialEvent extends TutorialEvent {
  int tutorialId;
  EnrollTutorialEvent(this.tutorialId, int selectedTab) : super(selectedTab);
}

class UnEnrollTutorialEvent extends TutorialEvent {
  int tutorialId;
  UnEnrollTutorialEvent(this.tutorialId, int selectedTab) : super(selectedTab);
}
