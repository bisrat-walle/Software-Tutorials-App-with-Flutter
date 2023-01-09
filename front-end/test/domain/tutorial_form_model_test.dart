import 'package:flutter_test/flutter_test.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/domain/tutorials/tutorial_form_model.dart';
import 'package:softwaretutorials/infrastructure/auth/authentication_service.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  final Tutorial tutorial = Tutorial(
    tutorialId: 3,
    content: "content",
    enrolled: false,
    enrollementCount: 0,
    instructor: User(
        id: 1,
        email: "b@b.com",
        fullName: "name",
        password: "skjfd",
        role: "CLIENT",
        username: "username"),
    project:
        Project(projectId: 1, problemStatement: "fsjklfds", title: "title"),
    submittedLink: "https://fdskl/cp,",
    title: "some title",
  );

  test('Tutorial Form Model Test', () {
    expect(TutorialFormModel.empty(), isA<TutorialFormModel>());
    expect(TutorialFormModel.fromTutorial(tutorial), isA<TutorialFormModel>());
  });
}
