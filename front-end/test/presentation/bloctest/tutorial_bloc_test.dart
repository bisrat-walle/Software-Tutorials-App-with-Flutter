import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/domain/tutorials/tutorial_form_model.dart';
import 'package:softwaretutorials/infrastructure/local_repository/tutorial_local_repository.dart';
import 'package:softwaretutorials/infrastructure/tutorials/enrollement_service.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';
import 'package:softwaretutorials/infrastructure/tutorials/tutorial_service.dart';
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart';
import 'package:test/test.dart';

import 'tutorial_bloc_test.mocks.dart';


final Tutorial tutorial = Tutorial(tutorialId: 3, content: "content", enrolled: false, 
  enrollementCount: 0, instructor: User(id: 1, email: "b@b.com", fullName: "name", 
  password: "skjfd", role: "CLIENT", username: "username"), 
  project: Project(projectId: 1, problemStatement: "fsjklfds", title: "title"),
  submittedLink: "https://fdskl/cp,", title: "some title", );
final TutorialFormModel tutorialForm = TutorialFormModel.fromTutorial(tutorial);

@GenerateMocks([ProfileRepository, EnrollementRepository, TutorialRepository, TutorialLocalRepository])
void main() {
  final mockTutorialRepository = MockTutorialRepository();
  final mockEnrollementRepository = MockEnrollementRepository();
  final mockLocalRepository = MockTutorialLocalRepository();
  late SharedPreferences prefs;
   group('TutorialBloc', () {
    blocTest<TutorialBloc, TutorialState>(
      'emits [] when nothing is added',
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      expect: () => [],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [ManageUser(0)] when GotoManageUserEvent(0) is added',
     setUp:() {
       
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(GotoManageUserEvent(0)),
      expect: () => [ManageUser(0)],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [TutorialDetailState(0)] when GotoTutorialDetailEvent(0) is added',
     setUp:() {
       
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(GotoTutorialDetailEvent(tutorial, 0)),
      expect: () => [TutorialDetailState(tutorial, 0)],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [CreateTutorialEvent(TutorialFormModel.empty(), 0)] when GotoCreateTutorialEvent(0) is added',
     setUp:() {
       
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(GotoCreateTutorialEvent(0)),
      expect: () => [CreateTutorialState(TutorialFormModel.empty(), 0)],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [TutorialLoadingState(0), AllTutorialsLoaded(list, 0)] when LoadAllTutorials(0) is added',
     setUp:() {
       when(mockTutorialRepository.getAllTutorials()).thenAnswer((realInvocation) => Future.value([tutorial, tutorial, tutorial]));
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(LoadAllTutorials(0)),
      expect: () => [TutorialLoadingState(0), AllTutorialsLoadedState([tutorial, tutorial, tutorial], 0)],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [TutorialLoadingState(0), LoadMyTutorials(list, 0)] when LoadMyTutorials(0) is added',
     setUp:() {
       when(mockTutorialRepository.getMyTutorials()).thenAnswer((realInvocation) => Future.value([tutorial, tutorial, tutorial]));
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(LoadMyTutorials(0)),
      expect: () => [TutorialLoadingState(0), MyTutorialsLoadedState([tutorial, tutorial, tutorial], 0)],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [TutorialLoadingState(0), EnrolledTutorialsLoaded(list, 0)] when LoadEnrolledTutorials(0) is added',
     setUp:() {
       when(mockTutorialRepository.getEnrolledTutorials()).thenAnswer((realInvocation) => Future.value([tutorial, tutorial, tutorial]));
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(LoadEnrolledTutorials(0)),
      expect: () => [TutorialLoadingState(0), EnrolledTutorialsLoaded([tutorial, tutorial, tutorial], 0)],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [TutorialLoadingState(0), AllTutorialsLoaded(list, 0)] when DeleteTutorialEvent(0) is added',
     setUp:() {
       when(mockTutorialRepository.deleteTutorial(tutorialId: 1)).thenAnswer((realInvocation) => Future.value(true)); 
     when(mockTutorialRepository.getAllTutorials()).thenAnswer((realInvocation) => Future.value([tutorial, tutorial, tutorial]));
     
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(DeleteTutorialEvent(1, 0)),
      expect: () => [TutorialLoadingState(0), AllTutorialsLoadedState([tutorial, tutorial, tutorial], 0)],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [TutorialLoadingState(0), AllTutorialsLoaded(list, 0)] when EnrollTutorialEvent(0) is added',
     setUp:() {
       when(mockEnrollementRepository.enroll(tutorialId: 1)).thenAnswer((realInvocation) => Future.value("")); 
     when(mockTutorialRepository.getAllTutorials()).thenAnswer((realInvocation) => Future.value([tutorial, tutorial, tutorial]));
     
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(EnrollTutorialEvent(1, 0)),
      expect: () => [TutorialLoadingState(0), AllTutorialsLoadedState([tutorial, tutorial, tutorial], 0)],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits [TutorialLoadingState(0), AllTutorialsLoaded(list, 0)] when UnEnrollTutorialEvent(0) is added',
     setUp:() {
       when(mockEnrollementRepository.unenroll(tutorialId: 1)).thenAnswer((realInvocation) => Future.value("")); 
     when(mockTutorialRepository.getAllTutorials()).thenAnswer((realInvocation) => Future.value([tutorial, tutorial, tutorial]));
     
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(UnEnrollTutorialEvent(1, 0)),
      expect: () => [TutorialLoadingState(0), AllTutorialsLoadedState([tutorial, tutorial, tutorial], 0)],
    );

    

    blocTest<TutorialBloc, TutorialState>(
      'emits [UpdateTutorialState(2)] when GotoUpdateTutorialEvent(0) is added',
     setUp:() {
       when(mockEnrollementRepository.unenroll(tutorialId: 1)).thenAnswer((realInvocation) => Future.value("")); 
     when(mockTutorialRepository.getAllTutorials()).thenAnswer((realInvocation) => Future.value([tutorial, tutorial, tutorial]));
     
     },
      build: () => TutorialBloc(mockTutorialRepository, mockLocalRepository, mockEnrollementRepository),
      act: (bloc) => bloc.add(GotoUpdateTutorialEvent(TutorialFormModel.fromTutorial(tutorial), 0)),
      expect: () => [UpdateTutorialState(TutorialFormModel.fromTutorial(tutorial), 2)],
    );


  
    

  });
}
