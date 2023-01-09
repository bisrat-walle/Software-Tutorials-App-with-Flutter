part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  NavigationState();
}

class NavigationInitial extends NavigationState {
  String toString() {
    return "Initial state";
  }

  @override
  List<Object?> get props => [];
}

class UpdateProfilePage extends NavigationState {
  String toString() {
    return "Initial state";
  }

  @override
  List<Object?> get props => [];
}

class SplashState extends NavigationState {
  @override
  String toString() {
    return "splash state";
  }

  @override
  List<Object?> get props => [];
}

class SigninPage extends NavigationState {
  @override
  String toString() {
    return "signin state";
  }

  @override
  List<Object?> get props => [];
}

class SignupPage extends NavigationState {
  @override
  String toString() {
    return "signup state";
  }

  @override
  List<Object?> get props => [];
}

class AllTutorialsPage extends NavigationState {
  @override
  String toString() {
    return "all tutorials state";
  }

  @override
  List<Object?> get props => [];
}

class EnrolledTutorialsPage extends NavigationState {
  @override
  String toString() {
    return "enrolled tutorials";
  }

  @override
  List<Object?> get props => [];
}

class MyTutorialsPage extends NavigationState {
  @override
  String toString() {
    return "my tutorials state";
  }

  @override
  List<Object?> get props => [];
}
