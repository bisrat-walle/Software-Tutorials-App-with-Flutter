import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/application/auth/theme_info.dart';
import 'package:softwaretutorials/infrastructure/local_repository/tutorial_local_repository.dart';
import 'package:softwaretutorials/infrastructure/local_repository/user_local_repository.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';
import 'package:softwaretutorials/infrastructure/tutorials/tutorial_service.dart';
import 'package:softwaretutorials/presentation/pages/signin/bloc/signin_bloc.dart';
import 'package:softwaretutorials/presentation/routes/app_router.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/presentation/routes/bloc_observer.dart';

import 'package:bloc/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance(); // for storing role and token
  BlocOverrides.runZoned(
   () {
     
    final _authenticationBloc = AuthenticationBloc(sharedPreferences);
    _authenticationBloc.add(AuthenticationInitialEvent());
    final _navigationBloc = NavigationBloc(_authenticationBloc);
	   _navigationBloc.add(NavigationInitialEvent());
     final _signinBloc = SigninBloc(_authenticationBloc);
    final _goRouter = TutorialGoRouter.get(_navigationBloc);


     runApp(
      MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TutorialLocalRepository()),
        RepositoryProvider(create: (context) => UserLocalRepository()),
        RepositoryProvider(create: (context) => ProfileRepository()),
        RepositoryProvider(create: (context) => TutorialRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => _authenticationBloc,
          ),
          BlocProvider<SigninBloc>(
            create: (context) => _signinBloc,
          ),
          BlocProvider<NavigationBloc>(
            create: (context) => _navigationBloc,
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Ethio Software Tutorials',
          theme: lightTheme(),
          routeInformationParser: _goRouter.routeInformationParser,
          routerDelegate: _goRouter.routerDelegate,
        ),
      ),
    ));
   },
   blocObserver: NavigationBlocObserver(),
 );
}
