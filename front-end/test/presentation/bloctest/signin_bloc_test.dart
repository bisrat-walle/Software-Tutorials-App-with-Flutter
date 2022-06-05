import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/domain/tutorials/tutorial_form_model.dart';
import 'package:softwaretutorials/infrastructure/tutorials/enrollement_service.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';
import 'package:softwaretutorials/infrastructure/tutorials/tutorial_service.dart';
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart';
import 'package:softwaretutorials/presentation/pages/signin/bloc/signin_bloc.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';
import 'package:test/test.dart';

import '../../application/authentication_bloc_test.mocks.dart';
import 'navigation_bloc_test.mocks.dart';
import 'signin_bloc_test.mocks.dart';
import 'tutorial_bloc_test.mocks.dart';

final User user = User(id: 1, email: "b@b.com", fullName: "name", 
  password: "skjfd", role: "CLIENT", username: "username");

@GenerateMocks([NavigationBloc])
void main() {
  final mockAuthenticationBloc = MockAuthenticationBloc();
  final mockAuthenticationRepository = MockAuthenticationRepository();
  final mockNavigationBloc = MockNavigationBloc();
  // final mockNavi
   group('SigninBloc', () {
	blocTest<SigninBloc, SigninState>(
      'emits [Loading(), Normal()] when AttemptSigninEvent is added and becomes successfull',
     setUp:() {
       when(mockAuthenticationRepository.authenticateUser(username:user.username, password:user.password)).thenAnswer((_) => Future.value(true));
     },
      build: () => SigninBloc(mockAuthenticationBloc, mockAuthenticationRepository)..add(AttemptLoginEvent(
				user.username!,  
				user.password!,
        mockNavigationBloc
        )),
      expect: () => [Loading(), Normal()],
    );
	
});
}

