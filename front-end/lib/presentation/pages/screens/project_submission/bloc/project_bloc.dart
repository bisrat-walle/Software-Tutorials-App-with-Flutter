import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/infrastructure/tutorials/project_service.dart';
import 'package:softwaretutorials/infrastructure/tutorials/tutorial_service.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final TutorialRepository tutorialRepository;
  final ProjectRepository projectRepository;
  ProjectBloc(this.tutorialRepository, this.projectRepository) : super(ProjectInitial()) {
    on<LoadTutorialEvent>((event, emit) async {
      emit(TutorialFetching());
      final tutorial = await tutorialRepository.getTutorial(event.tutorialId);
      final newState = SingleTutorialLoadedState();
      newState.message = event.message;
      newState.tutorial = tutorial;
      emit(newState);
    },);
    on<ProjectCreation>((event, emit) async {
      emit(ProjectSubmissionLoading());
      final res = await projectRepository.createProject(tutorialId: event.tutorialId, projectUrl: event.projectUrl);
      final newState = SingleTutorialLoadedState();
      final tutorial = await tutorialRepository.getTutorial(event.tutorialId);
      newState.tutorial = tutorial;
     if (res){
        add(LoadTutorialEvent.withMessage(event.tutorialId, "Project Successfully Submitted"));
      } else {
        add(LoadTutorialEvent.withMessage(event.tutorialId, "Unable to submit (try again)"));
      }
    });
    on<ProjectUpdate>((event, emit) async {
      emit(ProjectSubmissionLoading());
      final res = await projectRepository.updateProject(tutorialId: event.tutorialId, projectUrl: event.projectUrl);
      if (res){
        add(LoadTutorialEvent.withMessage(event.tutorialId, "Project Successfully Updated"));
      } else {
        add(LoadTutorialEvent.withMessage(event.tutorialId, "Unable to update (try again)"));
      }
    });
    on<ProjectDelete>((event, emit) async {
      emit(ProjectSubmissionLoading());
      final res = await projectRepository.deleteProject(tutorialId: event.tutorialId);
      if (res){
        add(LoadTutorialEvent.withMessage(event.tutorialId, "Project Successfully Deleted"));
      } else {
        add(LoadTutorialEvent.withMessage(event.tutorialId, "Unable to delete (try again)"));
      }
    });
  }
}
