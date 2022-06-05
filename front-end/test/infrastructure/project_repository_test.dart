
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/infrastructure/tutorials/project_service.dart';

import 'tutorial_repository_test.mocks.dart';

final baseUrl = "http://localhost:8080/api/v1/tutorials";


void main() {
  
  final client = MockClient();
  final projectRepository = ProjectRepository(client);

  final project = jsonEncode(<String, String?>{
					'projectUrl': "https://fsjlfsjlk.com"
				});
  group('Project Repository', () {
    final tutorialId = 1;
    test('returns true if a client successfully submit the project', () async {
      when(client
              .post(Uri.parse('$baseUrl/$tutorialId/project'), body: project))
          .thenAnswer((_) async =>
              http.Response("", 201));

      expect(await projectRepository.createProject(tutorialId: tutorialId, 
      projectUrl: "https://fsjlfsjlk.com"), true);
    });
     test('returns false if a client wasn\'t able submit the project', () async {
      when(client
              .post(Uri.parse('$baseUrl/$tutorialId/project'), body: project))
          .thenAnswer((_) async =>
              http.Response("", 400));

      expect(await projectRepository.createProject(tutorialId: tutorialId, 
      projectUrl: "https://fsjlfsjlk.com"), false);
    });
    test('returns true if a client successfully update the project', () async {
      when(client
              .put(Uri.parse('$baseUrl/$tutorialId/project'), body: project))
          .thenAnswer((_) async =>
              http.Response("", 204));

      expect(await projectRepository.updateProject(tutorialId: tutorialId, 
      projectUrl: "https://fsjlfsjlk.com"), true);
    });
     test('returns false if a client wasn\'t able update the project', () async {
      when(client
              .put(Uri.parse('$baseUrl/$tutorialId/project'), body: project))
          .thenAnswer((_) async =>
              http.Response("", 404));

      expect(await projectRepository.updateProject(tutorialId: tutorialId, 
      projectUrl: "https://fsjlfsjlk.com"), false);
    });
    test('returns true if a client successfully delete the project', () async {
      when(client
              .delete(Uri.parse('$baseUrl/$tutorialId/project')))
          .thenAnswer((_) async =>
              http.Response("", 204));

      expect(await projectRepository.deleteProject(tutorialId: tutorialId), true);
    });
     test('returns false if a client wasn\'t able delete the project', () async {
      when(client
              .delete(Uri.parse('$baseUrl/$tutorialId/project')))
          .thenAnswer((_) async =>
              http.Response("", 404));

      expect(await projectRepository.deleteProject(tutorialId: tutorialId), false);
    });
  });
}