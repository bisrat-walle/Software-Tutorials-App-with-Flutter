part of 'navigation_bloc.dart';

abstract class NavigationEvent {
  const NavigationEvent();
}

class NavigationInitialEvent extends NavigationEvent {}

class GotoSignin extends NavigationEvent {}

class GotoUpdateProfileState extends NavigationEvent {}

class GotoSignup extends NavigationEvent {}

class GotoAllTutorials extends NavigationEvent {}

class GotoMyTutorials extends NavigationEvent {}

class GotoEnrolledTutorials extends NavigationEvent {}
