part of 'navigation_bloc.dart';

abstract class NavigationState {
  NavigationState();
}

class NavigationInitial extends NavigationState {
String toString() {
    return "Initial state";
  }
}

class UpdateProfilePage extends NavigationState {
String toString() {
    return "Initial state";
  }
}

class SplashState extends NavigationState {
@override
String toString() {
    return "splash state";
  }
}

class SigninPage extends NavigationState {
@override
String toString() {
    return "signin state";
  }
}

class SignupPage extends NavigationState {
@override
String toString() {
    return "signup state";
  }
}

class AllTutorialsPage extends NavigationState {
@override
String toString() {
    return "all tutorials state";
  }
}

class EnrolledTutorialsPage extends NavigationState {
  @override
  String toString() {
      return "enrolled tutorials";
    }
}

class MyTutorialsPage extends NavigationState {
@override
String toString() {
    return "my tutorials state";
  }
}
