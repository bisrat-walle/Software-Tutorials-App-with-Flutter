import 'package:go_router/go_router.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/presentation/pages/screens/screens.dart';
import 'package:softwaretutorials/presentation/pages/screens/update_profile/update_profile_screen.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';

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
        GoRoute(
          path: APP_PAGE.updateProfile.toPath,
          name: APP_PAGE.updateProfile.toName,
          builder: (context, state) => UpdateProfileScreen(),
        ),
      ],
      //errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
      redirect: (state) {
        final loginLocation = state.namedLocation(APP_PAGE.login.toName);
        final tutorialsLocation =
            state.namedLocation(APP_PAGE.tutorials.toName);
        final splashLocation = state.namedLocation(APP_PAGE.splash.toName);
        final signupLocation = state.namedLocation(APP_PAGE.signup.toName);
        final updateProfileLocation =
            state.namedLocation(APP_PAGE.updateProfile.toName);

        if (navigationBloc.state is SplashState &&
            state.subloc != splashLocation) {
          return splashLocation;
        }

        if (navigationBloc.state is UpdateProfilePage &&
            state.subloc != updateProfileLocation) {
          return updateProfileLocation;
        }

        if (navigationBloc.state is SigninPage &&
            state.subloc != loginLocation) {
          return loginLocation;
        }

        if (navigationBloc.state is SignupPage &&
            state.subloc != signupLocation) {
          return signupLocation;
        }

        if (navigationBloc.state is AllTutorialsPage &&
            state.subloc != tutorialsLocation) {
          return tutorialsLocation;
        }
        return null;
      },
    );
  }
}
