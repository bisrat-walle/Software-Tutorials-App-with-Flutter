import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/infrastructure/auth/authentication_service.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/infrastructure/auth/authentication_service.dart';

import 'authentication_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {

  SharedPreferences.setMockInitialValues({});
	late final mockSharedPreferences;
	final mockAuthenticationRepository = MockAuthenticationRepository();

	group('AuthenticationBloc', () {

    setUp(() async {
       mockSharedPreferences =  await SharedPreferences.getInstance();
    },);
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [Loading, Authenticated] when user has already been authenticated',
     setUp:() {
	 
		 when(mockAuthenticationRepository
              .getLoginStatus())
          .thenAnswer((_) async => Future.value(true));
       
     },
      build: () => AuthenticationBloc(mockSharedPreferences, mockAuthenticationRepository),
      expect: () => [Loading(), Authenticated()],
    );
	
	blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [Loading, UnAuthenticated] when user has not been authenticated',
     setUp:() {
	 
		 when(mockAuthenticationRepository
              .getLoginStatus())
          .thenAnswer((_) async => Future.value(false));
       
     },
      build: () => AuthenticationBloc(mockSharedPreferences, mockAuthenticationRepository),
      expect: () => [Loading(), UnAuthenticated()],
    );
	});

}