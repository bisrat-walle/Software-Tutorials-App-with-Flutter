import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/domain/tutorials/tutorial_form_model.dart';
import 'package:softwaretutorials/infrastructure/tutorials/project_service.dart';
import 'package:softwaretutorials/presentation/pages/screens/project_submission/bloc/project_bloc.dart';
import 'package:test/test.dart';

import 'project_submission_bloc_test.mocks.dart';
import 'tutorial_bloc_test.mocks.dart';


final Tutorial tutorial = Tutorial(tutorialId: 1, content: "content", enrolled: false, 
  enrollementCount: 0, instructor: User(id: 1, email: "b@b.com", fullName: "name", 
  password: "skjfd", role: "CLIENT", username: "username"), 
  project: Project(projectId: 1, problemStatement: "fsjklfds", title: "title"),
  submittedLink: "https://fdskl/cp,", title: "some title", );
final TutorialFormModel tutorialForm = TutorialFormModel.fromTutorial(tutorial);


@GenerateMocks([ProjectRepository])
void main() {
  final mockTutorialRepository = MockTutorialRepository();
  final mockProjectRepository = MockProjectRepository();
  ProjectState expectedState = SingleTutorialLoadedState();
		expectedState.tutorial = tutorial;
  
   group('ProjectBloc', () {
	
	blocTest<ProjectBloc, ProjectState>(
      'emits [TutorialFetching(), SingleTutorialLoadedState()] when LoadTutorialEvent is added',
     setUp:() {
		when(mockTutorialRepository.getTutorial(tutorial.tutorialId)).thenAnswer((realInvocation) => Future.value(tutorial));
	 },
      build: () => ProjectBloc(mockTutorialRepository, mockProjectRepository)..add(LoadTutorialEvent(tutorial.tutorialId!)),
      expect: () => [TutorialFetching(), expectedState],
    );
	
	blocTest<ProjectBloc, ProjectState>(
      'emits [ProjectSubmissionLoading(), TutorialFetching(), SingleTutorialLoadedState()] when ProjectCreation is added',
     setUp:() {
		expectedState.message = "Project Successfully Submitted";
		when(mockTutorialRepository.getTutorial(tutorial.tutorialId)).thenAnswer((realInvocation) => Future.value(tutorial));
		when(mockProjectRepository.createProject(tutorialId: 1, projectUrl: "projectUrl")).thenAnswer((_) => Future.value(true));
	 },
      build: () => ProjectBloc(mockTutorialRepository, mockProjectRepository)..add(ProjectCreation(tutorial.tutorialId!, "projectUrl")),
      expect: () => [ProjectSubmissionLoading(), TutorialFetching(), expectedState],
    );
	
	blocTest<ProjectBloc, ProjectState>(
      'emits [ProjectSubmissionLoading(), SingleTutorialLoadedState()] when ProjectUpdate is added',
     setUp:() {
		expectedState.message = "Project Successfully Updated";
		when(mockTutorialRepository.getTutorial(tutorial.tutorialId)).thenAnswer((realInvocation) => Future.value(tutorial));
		when(mockProjectRepository.updateProject(tutorialId: 1, projectUrl: "projectUrl")).thenAnswer((_) => Future.value(true));
	 },
      build: () => ProjectBloc(mockTutorialRepository, mockProjectRepository)..add(ProjectUpdate(tutorial.tutorialId!, "projectUrl")),
      expect: () => [ProjectSubmissionLoading(), TutorialFetching(), expectedState],
    );
	
	
	
	blocTest<ProjectBloc, ProjectState>(
      'emits [ProjectSubmissionLoading(), SingleTutorialLoadedState()] when ProjectDelete is added',
     setUp:() {
		expectedState.message = "Project Successfully Deleted";
		when(mockTutorialRepository.getTutorial(tutorial.tutorialId)).thenAnswer((realInvocation) => Future.value(tutorial));
		when(mockProjectRepository.deleteProject(tutorialId: 1)).thenAnswer((_) => Future.value(true));
	 },
      build: () => ProjectBloc(mockTutorialRepository, mockProjectRepository)..add(ProjectDelete(tutorial.tutorialId!)),
      expect: () => [ProjectSubmissionLoading(), TutorialFetching(), expectedState],
    );
	
	});
}
	