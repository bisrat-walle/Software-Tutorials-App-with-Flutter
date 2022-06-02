import 'package:flutter/material.dart';
import 'theme_info.dart';
import 'models/models.dart';
import 'package:provider/provider.dart';
import 'navigation/app_router.dart';
import 'package:go_router/go_router.dart';
import 'screens/screens.dart';


class Home extends StatefulWidget {
  final sharedPreferences;
  const Home({Key? key, this.sharedPreferences}) : super(key: key);
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final _appStateManger;
  late final _goRouter = GoRouter(
		refreshListenable: _appStateManger,
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

			  final isLogedIn = _appStateManger.isLoggedIn;
			  final isInitialized = _appStateManger.isInitialized;

			  final isGoingToLogin = state.subloc == loginLocation;
			  final isGoingToInit = state.subloc == splashLocation;
			  final isSignupState = _appStateManger.isSignupState;

			  // If not Initialized and not going to Initialized redirect to Splash
			  if (!isInitialized && !isGoingToInit) {
				return splashLocation;
			  // If not onboard and not going to onboard redirect to OnBoarding
			  } 
			  else if (isInitialized && !isLogedIn && !isGoingToLogin) {
				return loginLocation;
			  // If all the scenarios are cleared but still going to any of that screen redirect to Home
			  } else if ((isLogedIn && isGoingToLogin) || (isInitialized && isGoingToInit)) {
				return tutorialsLocation;
			  } //else if (isInitialized && isSignupState && isGoingToLogin){
				//return signupLocation;
			  //} 
			  else {
			  // Else Don't do anything
				return null;
			  }
		  
		},
	);
  
  @override
  void initState(){
    _appStateManger = AppStateManager(sharedPreferences: widget.sharedPreferences);
	super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
	  
    return MultiProvider(
	  providers: [
	    ChangeNotifierProvider<AppStateManager>(create: (_) => _appStateManger),
	  ],
	  child: MaterialApp.router(
		  debugShowCheckedModeBanner: false,
		  title: 'Ethio Software Tutorials',
		  theme: lightTheme(),
		  routeInformationParser: _goRouter.routeInformationParser,
          routerDelegate: _goRouter.routerDelegate,
		)
	);
  }
}