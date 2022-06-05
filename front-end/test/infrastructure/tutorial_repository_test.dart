import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/infrastructure/tutorials/tutorial_service.dart';

import 'tutorial_repository_test.mocks.dart';

final baseUrl = "http://localhost:8080/api/v1/tutorials";

final mockTutorialList = <Tutorial> [
	Tutorial(
  tutorialId: 3,title: "title", content: "content", 
	project: Project(projectId: 3, title: "projectTitle", 
	problemStatement: "problemStatement"), enrolled: false, enrollementCount: 1, 
  instructor: User(email: "email", fullName: "name", id: 1, password: "sfdk", role: "CLIENT", username: "Name"), submittedLink: null),
	Tutorial(
  tutorialId: 3,title: "title", content: "content", 
	project: Project(projectId: 3, title: "projectTitle", 
	problemStatement: "problemStatement"), enrolled: false, enrollementCount: 1, 
  instructor: User(email: "email", fullName: "name", id: 1, password: "sfdk", role: "CLIENT", username: "Name"), submittedLink: null),
	Tutorial(
  tutorialId: 3,title: "title", content: "content", 
	project: Project(projectId: 3, title: "projectTitle", 
	problemStatement: "problemStatement"), enrolled: false, enrollementCount: 1, 
  instructor: User(email: "email", fullName: "name", id: 1, password: "sfdk", role: "CLIENT", username: "Name"), submittedLink: null),
];

@GenerateMocks([http.Client])
void main() {
  
  final client = MockClient();
  final tutorialRepository = TutorialRepository(client);
  group('TutorialRepository', () {
    test('returns list of all tutorials if the http call completes successfully', () async {
      when(client
              .get(Uri.parse('$baseUrl/all/c')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(mockTutorialList.map((item) => item.toJson()).toList()), 200));

      expect(await tutorialRepository.getAllTutorials(), isA<List<Tutorial>>());
    });
    test('throws an exception when it fails to load tutorials', () async {
      when(client
              .get(Uri.parse('$baseUrl/all/c')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(mockTutorialList.map((item) => item.toJson()).toList()), 403));

      expect(tutorialRepository.getAllTutorials(), throwsException);
    });

    test('returns list of enrolled tutorials if the http call completes successfully', () async {
      when(client
              .get(Uri.parse('$baseUrl/enrolled')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(mockTutorialList.map((item) => item.toJson()).toList()), 200));

      expect(await tutorialRepository.getEnrolledTutorials(), isA<List<Tutorial>>());
    });
    test('throws an exception when it fails to load enrolled tutorials', () async {
      when(client
              .get(Uri.parse('$baseUrl/enrolled')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(mockTutorialList.map((item) => item.toJson()).toList()), 403));

      expect(tutorialRepository.getEnrolledTutorials(), throwsException);
    });

     test('returns list of my tutorials if the http call completes successfully', () async {
      when(client
              .get(Uri.parse('$baseUrl/mytutorials')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(mockTutorialList.map((item) => item.toJson()).toList()), 200));

      expect(await tutorialRepository.getMyTutorials(), isA<List<Tutorial>>());
    });
    test('throws an exception when it fails to load my tutorials', () async {
      when(client
              .get(Uri.parse('$baseUrl/mytutorials')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(mockTutorialList.map((item) => item.toJson()).toList()), 403));

      expect(tutorialRepository.getMyTutorials(), throwsException);
    });
    test('returns true when it creates tutorial successfully after http call', () async {
      final tutorial = mockTutorialList[0];
      when(client
              .post(Uri.parse('$baseUrl/'), body: jsonEncode(<String, dynamic>{"title": tutorial.title!, "content": tutorial.content!, "project": {
                "title": tutorial.project!.title!,
          "problemStatement": tutorial.project!.problemStatement!
              }})))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(tutorial.toJson()), 201));
      expect(await tutorialRepository.createTutorial(
        title: tutorial.title!, content: tutorial.content!, projectTitle: tutorial.project!.title!,
          problemStatement: tutorial.project!.problemStatement!), true);
    });

    test('returns false when the http call to create tutorial fails', () async {
      final tutorial = mockTutorialList[0];
      when(client
              .post(Uri.parse('$baseUrl/'), body: jsonEncode(<String, dynamic>{"title": tutorial.title!, "content": tutorial.content!, "project": {
                "title": tutorial.project!.title!,
          "problemStatement": tutorial.project!.problemStatement!
              }})))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(tutorial.toJson()), 403));
      expect(await tutorialRepository.createTutorial(
        title: tutorial.title!, content: tutorial.content!, projectTitle: tutorial.project!.title!,
          problemStatement: tutorial.project!.problemStatement!), false);
    });

     test('returns true when it updates tutorial successfully after http call', () async {
      final tutorial = mockTutorialList[0];
      when(client
              .put(Uri.parse('$baseUrl/${tutorial.tutorialId!}'), body: jsonEncode(<String, dynamic>{"title": tutorial.title!, "content": tutorial.content!, "project": {
                "title": tutorial.project!.title!,
          "problemStatement": tutorial.project!.problemStatement!
              }})))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(tutorial.toJson()), 201));
      expect(await tutorialRepository.updateTutorial(
        tutorialId: tutorial.tutorialId!,
        title: tutorial.title!, content: tutorial.content!, projectTitle: tutorial.project!.title!,
          problemStatement: tutorial.project!.problemStatement!), true);
    });

    test('returns false when it fails to update tutorial successfully after http call', () async {
      final tutorial = mockTutorialList[0];
      when(client
              .put(Uri.parse('$baseUrl/${tutorial.tutorialId!}'), body: jsonEncode(<String, dynamic>{"title": tutorial.title!, "content": tutorial.content!, "project": {
                "title": tutorial.project!.title!,
          "problemStatement": tutorial.project!.problemStatement!
              }})))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(tutorial.toJson()), 403));
      expect(await tutorialRepository.updateTutorial(
        tutorialId: tutorial.tutorialId!,
        title: tutorial.title!, content: tutorial.content!, projectTitle: tutorial.project!.title!,
          problemStatement: tutorial.project!.problemStatement!), false);
    });

    test('returns false when it successfully deletes tutorial successfully after http call', () async {
      final tutorial = mockTutorialList[0];
      when(client
              .delete(Uri.parse('$baseUrl/${tutorial.tutorialId!}'), body: jsonEncode(<String, dynamic>{"title": tutorial.title!, "content": tutorial.content!, "project": {
                "title": tutorial.project!.title!,
          "problemStatement": tutorial.project!.problemStatement!
              }})))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(tutorial.toJson()), 204));
      expect(await tutorialRepository.deleteTutorial(
        tutorialId: tutorial.tutorialId!),  false);
    });

    test('returns false when it fails to delete tutorial successfully after http call', () async {
      final tutorial = mockTutorialList[0];
      when(client
              .delete(Uri.parse('$baseUrl/${tutorial.tutorialId!}'), body: jsonEncode(<String, dynamic>{"title": tutorial.title!, "content": tutorial.content!, "project": {
                "title": tutorial.project!.title!,
          "problemStatement": tutorial.project!.problemStatement!
              }})))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(tutorial.toJson()), 403));
      expect(await tutorialRepository.deleteTutorial(
        tutorialId: tutorial.tutorialId!),  false);
    });
    
  });
  
}
	  