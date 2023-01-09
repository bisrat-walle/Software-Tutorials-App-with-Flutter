import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/infrastructure/auth/authentication_service.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';
import 'package:test/test.dart';

import '../../application/authentication_bloc_test.mocks.dart';
import 'navigation_bloc_test.mocks.dart';
import 'signin_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationBloc])
void main() {
  final mockAuthenticationRepository = MockAuthenticationRepository();
  final mockAuthenticationBloc = MockAuthenticationBloc();
  group('NavigationBloc', () {
    late NavigationBloc navBloc;
    blocTest<NavigationBloc, NavigationState>(
      'emits [SplashState(), AllTutorialsPage()] when nothing is added and user was successfully authenticated',
      setUp: () {
        when(mockAuthenticationBloc.state).thenAnswer(
          (realInvocation) => Authenticated(),
        );
        when(mockAuthenticationRepository.getLoginStatus())
            .thenAnswer((realInvocation) => Future.value(true));
      },
      wait: const Duration(seconds: 3),
      act: (bloc) async => bloc.add(NavigationInitialEvent()),
      build: () => NavigationBloc(mockAuthenticationBloc),
      expect: () => [SplashState(), AllTutorialsPage()],
    );

    blocTest<NavigationBloc, NavigationState>(
      'emits [SplashState(), SigninPage()] when nothing is added and user wasn\'t successfully authenticated',
      setUp: () {
        when(mockAuthenticationBloc.state).thenAnswer(
          (realInvocation) => UnAuthenticated(),
        );
        when(mockAuthenticationRepository.getLoginStatus())
            .thenAnswer((realInvocation) => Future.value(false));
      },
      wait: const Duration(seconds: 3),
      act: (bloc) async => bloc.add(NavigationInitialEvent()),
      build: () => NavigationBloc(mockAuthenticationBloc),
      expect: () => [SplashState(), SigninPage()],
    );

    blocTest<NavigationBloc, NavigationState>(
      'emits [UpdateProfileState()] when GotoUpdateProfileState is added',
      setUp: () {
        mockAuthenticationBloc.emit(Authenticated());

        when(mockAuthenticationRepository.getLoginStatus())
            .thenAnswer((realInvocation) => Future.value(true));
      },
      act: (bloc) async => bloc.add(GotoUpdateProfileState()),
      build: () => NavigationBloc(mockAuthenticationBloc),
      expect: () => [UpdateProfilePage()],
    );

    blocTest<NavigationBloc, NavigationState>(
      'emits [SigninPage()] when SigninPage is added',
      setUp: () {
        mockAuthenticationBloc.emit(Authenticated());
      },
      act: (bloc) async => bloc.add(GotoSignin()),
      build: () => NavigationBloc(mockAuthenticationBloc),
      expect: () => [SigninPage()],
    );

    blocTest<NavigationBloc, NavigationState>(
      'emits [SignupPage()] when SignupPage is added',
      setUp: () {
        mockAuthenticationBloc.emit(Authenticated());
        when(mockAuthenticationRepository.getLoginStatus())
            .thenAnswer((realInvocation) => Future.value(true));
      },
      act: (bloc) async => bloc.add(GotoSignup()),
      build: () => NavigationBloc(mockAuthenticationBloc),
      expect: () => [SignupPage()],
    );

    blocTest<NavigationBloc, NavigationState>(
      'emits [AllTutorialsPage()] when GotoAllTutorials is added',
      setUp: () {
        mockAuthenticationBloc.emit(Authenticated());
        when(mockAuthenticationRepository.getLoginStatus())
            .thenAnswer((realInvocation) => Future.value(true));
      },
      act: (bloc) async => bloc.add(GotoAllTutorials()),
      build: () => NavigationBloc(mockAuthenticationBloc),
      expect: () => [AllTutorialsPage()],
    );

    blocTest<NavigationBloc, NavigationState>(
      'emits [EnrolledTutorialsPage()] when GotoEnrolledTutorials is added',
      setUp: () {
        mockAuthenticationBloc.emit(Authenticated());
      },
      act: (bloc) async => bloc.add(GotoEnrolledTutorials()),
      build: () =>
          NavigationBloc(mockAuthenticationBloc)..add(GotoEnrolledTutorials()),
      expect: () => [EnrolledTutorialsPage()],
    );

    blocTest<NavigationBloc, NavigationState>(
      'emits [MyTutorialsPage()] when GotoMyTutorialsPage is added',
      setUp: () {
        mockAuthenticationBloc.emit(Authenticated());
      },
      act: (bloc) async => bloc.add(GotoMyTutorials()),
      build: () => NavigationBloc(mockAuthenticationBloc),
      expect: () => [MyTutorialsPage()],
    );
  });
}
