import 'dart:developer';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:softwaretutorials/domain/models/models.dart';
import 'package:softwaretutorials/home.dart';
import 'package:softwaretutorials/presentation/pages/screens/screens.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';
import 'navigation_bloc_wrapper.dart';

class TutorialGoRouter {
  static GoRouter get(NavigationBloc navigationBloc) {
    return GoRouter(
		urlPathStrategy: UrlPathStrategy.path,
		refreshListenable: GoRouterRefreshStream(navigationBloc.stream),
		initialLocation: APP_PAGE.splash.toPath,
		routes: <GoRoute>[
		  GoRoute(
			path: APP_PAGE.splash.toPath,
			name: APP_PAGE.splash.toName,
			builder: (context, state) => SplashScreen(),
		  ),
		  GoRoute(
			path: APP_PAGE.login.toPath,
			name: APP_PAGE.login.toName,
			builder: (context, state) => LoginScreen(),
		  ),
		  GoRoute(
			path: APP_PAGE.signup.toPath,
			name: APP_PAGE.signup.toName,
			builder: (context, state) => SignupScreen(),
		  ),
		  GoRoute(
			path: APP_PAGE.tutorials.toPath,
			name: APP_PAGE.tutorials.toName,
			builder: (context, state) => TutorialScreen(),
		  ),
		],
		//errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
		redirect: (state) {
		    final loginLocation = state.namedLocation(APP_PAGE.login.toName);
			  final tutorialsLocation = state.namedLocation(APP_PAGE.tutorials.toName);
			  final splashLocation = state.namedLocation(APP_PAGE.splash.toName);
			  final signupLocation = state.namedLocation(APP_PAGE.signup.toName);
		
		print("Navigation redirect "+ navigationBloc.state.toString());
        
        if(navigationBloc.state is SplashState && state.subloc != splashLocation){
          return splashLocation;
        }

			  if (navigationBloc.state is SigninPage && state.subloc != loginLocation){
          return loginLocation;
        }

        if (navigationBloc.state is SignupPage && state.subloc != signupLocation){
          return signupLocation;
        }

        if (navigationBloc.state is AllTutorialsPage && state.subloc != tutorialsLocation){
          return tutorialsLocation;
        }
        return null;
		  
		},
	);
  }
}