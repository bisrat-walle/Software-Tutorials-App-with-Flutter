import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:softwaretutorials/domain/models/tutorial_form_model.dart';
import 'package:softwaretutorials/infrastructure/repositories/tutorial_service.dart';
import 'package:softwaretutorials/domain/models/tutorial.dart';
import 'package:softwaretutorials/presentation/pages/screens/manageuser/bloc/manageuser_bloc.dart';

part 'tutorial_event.dart';
part 'tutorial_state.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  TutorialBloc() : super(TutorialLoadingState(0)) {
    on<GotoManageUserEvent>(
      (event, emit) {
        emit(ManageUser(event.selectedTab));
      },
    );
    on<GotoTutorialDetailEvent>(
      (event, emit) {
        print("tutorial detail tab selected "+event.selectedTab.toString());
        emit(TutorialDetailState(event.tutorial, event.selectedTab));
      },
    );
    on<GotoCreateTutorialEvent>((event, emit) {
      emit(CreateTutorialState(TutorialFormModel.empty(), event.selectedTab));
    },);
    on<LoadAllTutorials>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final tutorialList = await TutorialRepository.getAllTutorials();
      emit(AllTutorialsLoadedState(tutorialList, event.selectedTab));
    });
    on<LoadMyTutorials>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final tutorialList = await TutorialRepository.getMyTutorials();
      emit(MyTutorialsLoadedState(tutorialList, event.selectedTab));
    });
    on<GotoUpdateTutorialEvent>(
      (event, emit) {
        emit(UpdateTutorialState(event.tutorialForm, 2));
      },
    );
    on<CreateTutorialEvent>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final res = await TutorialRepository.createTutorial(
        content: event.tutorialForm.contentController.text,
        title: event.tutorialForm.titleController.text,
        problemStatement: event.tutorialForm.problemStatementController.text,
        projectTitle: event.tutorialForm.projectTitleController.text,
      );
      emit(TutorialLoadingState(event.selectedTab));
    });
    on<UpdateTutorialEvent>(
      (event, emit) async {
        final res = await TutorialRepository.updateTutorial(
        content: event.tutorialForm.contentController.text,
        title: event.tutorialForm.titleController.text,
        problemStatement: event.tutorialForm.problemStatementController.text,
        projectTitle: event.tutorialForm.projectTitleController.text,
        tutorialId: event.tutorialForm.tutorialId!
      );
      emit(TutorialInitialState(event.selectedTab));
      },
    );
  }
}
