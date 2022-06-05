
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/infrastructure/tutorials/enrollement_service.dart';

import 'tutorial_repository_test.mocks.dart';

final baseUrl = "http://localhost:8080/api/v1/tutorials";

void main() {
  
  final client = MockClient();
  final enrollementRepository = EnrollementRepository(client);
  group('EnrollementRepository', () {
    final tutorialId = 1;
    test('returns Tutorial successfully enrolled if http call successfully enrolls the client', () async {
      when(client
              .post(Uri.parse('$baseUrl/$tutorialId/enroll')))
          .thenAnswer((_) async =>
              http.Response("", 204));

      expect(await enrollementRepository.enroll(tutorialId: 1), "Tutorial successfully enrolled");
    });
     test('returns Unable to enroll if http call successfully enrolls the client', () async {
      when(client
              .post(Uri.parse('$baseUrl/$tutorialId/enroll')))
          .thenAnswer((_) async =>
              http.Response("", 400));

      expect(await enrollementRepository.enroll(tutorialId: 1), "Unable to enroll");
    });
    test('returns Tutorial successfully unenrolled if http call successfully enrolls the client', () async {
      when(client
              .delete(Uri.parse('$baseUrl/enrolled/$tutorialId')))
          .thenAnswer((_) async =>
              http.Response("", 204));

      expect(await enrollementRepository.unenroll(tutorialId: tutorialId), "Tutorial successfully unenrolled");
    });
     test('returns Unable to unenroll if http call successfully enrolls the client', () async {
      when(client
              .delete(Uri.parse('$baseUrl/enrolled/$tutorialId')))
          .thenAnswer((_) async =>
              http.Response("", 400));

      expect(await enrollementRepository.unenroll(tutorialId: tutorialId), "Unable to unenroll");
    });
  });
}