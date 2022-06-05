import 'package:bloc_test/bloc_test.dart';

import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/presentation/pages/screens/manageuser/bloc/manageuser_bloc.dart';

import 'tutorial_bloc_test.mocks.dart';
import 'package:test/test.dart';

final mockUserList = [User(id: 1, email: "b@b.com", fullName: "name", 
  password: "skjfd", role: "CLIENT", username: "username"), User(id: 2, email: "b@b.com", fullName: "name", 
  password: "skjfd", role: "CLIENT", username: "username")];

void main() {
	final mockProfileRepository = MockProfileRepository();

	group('ManageUserBloc', () {
    blocTest<ManageuserBloc, ManageuserState>(
      'emits [ManageUserLoading, ManageUserScreenState] when user data has successfully been loaded',
     setUp:() {
	 
		 when(mockProfileRepository
              .getAllUsers())
          .thenAnswer((_) async => Future.value(Future.value(mockUserList)));
       
     },
      build: () => ManageuserBloc(mockProfileRepository)..add(GotoManageUserScreenEvent()),
      expect: () => [ManageUserLoading(), ManageUserScreenState()],
    );
	
	});

}