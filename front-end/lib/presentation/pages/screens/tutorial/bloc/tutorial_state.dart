part of 'tutorial_bloc.dart';

abstract class TutorialState extends Equatable {

  int selectedTab = 0;

  TutorialState(this.selectedTab);
  
  @override
  List<Object> get props => [selectedTab];
}

abstract class TutorialLoadedState extends TutorialState {
  late List<Tutorial> tutorialList;

  TutorialLoadedState(int selectedTab) : super(selectedTab);
}

abstract class TutorialUpdate extends TutorialState {
  late TutorialFormModel tutorialForm;

  TutorialUpdate(int selectedTab) : super(selectedTab);
}

class ManageUser extends TutorialState {
  ManageUser(int selectedTab) : super(selectedTab);
}

class TutorialInitialState extends TutorialState {
  TutorialInitialState(int selectedTab) : super(selectedTab);
}
class TutorialDetailState extends TutorialState {
  final Tutorial tutorial;
  TutorialDetailState(this.tutorial, int selectedTab) : super(selectedTab);
}
class TutorialLoadingState extends TutorialState {
  TutorialLoadingState(int selectedTab) : super(selectedTab);
}
class CreateTutorialState extends TutorialState implements TutorialUpdate{
  late TutorialFormModel tutorialForm;
  CreateTutorialState(this.tutorialForm, int selectedTab) : super(selectedTab);
}
class UpdateTutorialState extends TutorialState implements TutorialUpdate{
  @override
  late TutorialFormModel tutorialForm;
UpdateTutorialState(tutorialForm, int selectedTab) : super(selectedTab){
  this.tutorialForm = tutorialForm;
}

}

class AllTutorialsLoadedState extends TutorialState implements TutorialLoadedState{
  int selectedTab = 0;
  List<Tutorial> tutorialList;
  AllTutorialsLoadedState(this.tutorialList,int selectedTab) : super(selectedTab);

  
  @override
  List<Object> get props => [tutorialList];
}

class EnrolledTutorialsLoaded extends TutorialState implements TutorialLoadedState{
  int selectedTab = 1;
  List<Tutorial> tutorialList;
  EnrolledTutorialsLoaded(this.tutorialList, int selectedTab) : super(selectedTab);

  @override
  List<Object> get props => [tutorialList];
}

class MyTutorialsLoadedState extends TutorialState implements TutorialLoadedState{
  List<Tutorial> tutorialList;
  MyTutorialsLoadedState(this.tutorialList, int selectedTab) : super(selectedTab);

  @override
  List<Object> get props => [tutorialList];
}