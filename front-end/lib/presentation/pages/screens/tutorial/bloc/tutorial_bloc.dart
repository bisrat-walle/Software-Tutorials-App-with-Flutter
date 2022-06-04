import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/domain/tutorials/tutorial_form_model.dart';
import 'package:softwaretutorials/infrastructure/tutorials/enrollement_service.dart';
import 'package:softwaretutorials/infrastructure/tutorials/tutorial_service.dart';

part 'tutorial_event.dart';
part 'tutorial_state.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  final TutorialRepository tutorialRepository;
  final EnrollementRepository enrollementRepository;
  TutorialBloc(this.tutorialRepository, this.enrollementRepository) : super(TutorialLoadingState(0)) {
    on<GotoManageUserEvent>(
      (event, emit) {
        final newState = ManageUser(event.selectedTab);
        newState.message = event.message;
        emit(newState);
      },
    );
    on<GotoTutorialDetailEvent>(
      (event, emit) {
        final newState =TutorialDetailState(event.tutorial, event.selectedTab);
        newState.message = event.message;
        emit(newState);
      },
    );
    on<GotoCreateTutorialEvent>((event, emit) {
      final newState = CreateTutorialState(TutorialFormModel.empty(), event.selectedTab);
      newState.message = event.message;
      emit(newState);
    },);
    on<LoadAllTutorials>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final tutorialList = await tutorialRepository.getAllTutorials();
      final newState = AllTutorialsLoadedState(tutorialList, event.selectedTab);
      newState.message = event.message;
      emit(newState);
    });
    on<LoadMyTutorials>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final tutorialList = await tutorialRepository.getMyTutorials();
      final newState = MyTutorialsLoadedState(tutorialList, event.selectedTab);
      newState.message = event.message;
      emit(newState);
    });
    on<LoadEnrolledTutorials>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final tutorialList = await tutorialRepository.getEnrolledTutorials();
      final newState = EnrolledTutorialsLoaded(tutorialList, event.selectedTab);
      newState.message = event.message;
      emit(newState);
    });
    on<DeleteTutorialEvent>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final res = await tutorialRepository.deleteTutorial(tutorialId: event.tutorialId);
      if (res){
        if (event.selectedTab == 0){
          add(LoadAllTutorials(event.selectedTab));
        } else {
          add(LoadAllTutorials(event.selectedTab));
        }
      }
    },);
    on<EnrollTutorialEvent>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final String? res = await enrollementRepository.enroll(tutorialId: event.tutorialId);
      if (event.selectedTab == 0){
          final newState = LoadAllTutorials(event.selectedTab);
          newState.message = res!;
          add(newState);
        } else {
          final newState = LoadEnrolledTutorials(event.selectedTab);
          newState.message = res!;
          add(newState);
        }  
      
    },);
    on<UnEnrollTutorialEvent>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final String? res = await enrollementRepository.unenroll(tutorialId: event.tutorialId);
        if (event.selectedTab == 0){
          final newState = LoadAllTutorials(event.selectedTab);
          newState.message = res!;
          add(newState);
        } else {
          final newState = LoadEnrolledTutorials(event.selectedTab);
          newState.message = res!;
          add(newState);
        }
      
    },);
    on<GotoUpdateTutorialEvent>(
      (event, emit) {
      final newState = UpdateTutorialState(event.tutorialForm, 2);
      newState.message = event.message;
      emit(newState);
      },
    );
    on<CreateTutorialEvent>((event, emit) async {
      emit(TutorialLoadingState(event.selectedTab));
      final res = await tutorialRepository.createTutorial(
        content: event.tutorialForm.contentController.text,
        title: event.tutorialForm.titleController.text,
        problemStatement: event.tutorialForm.problemStatementController.text,
        projectTitle: event.tutorialForm.projectTitleController.text,
      );
      add(LoadMyTutorials(1));
    });
    on<UpdateTutorialEvent>(
      (event, emit) async {
        final res = await tutorialRepository.updateTutorial(
        content: event.tutorialForm.contentController.text,
        title: event.tutorialForm.titleController.text,
        problemStatement: event.tutorialForm.problemStatementController.text,
        projectTitle: event.tutorialForm.projectTitleController.text,
        tutorialId: event.tutorialForm.tutorialId!
      );if (res)
      add(LoadMyTutorials(1));
      },
    );
  }
}
