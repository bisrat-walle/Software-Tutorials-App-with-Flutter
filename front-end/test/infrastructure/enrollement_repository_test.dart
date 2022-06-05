
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/infrastructure/tutorials/enrollement_service.dart';

import '../presentation/bloctest/project_submission_bloc_test.dart';
import '../presentation/bloctest/tutorial_bloc_test.mocks.dart';
import 'tutorial_repository_test.mocks.dart';

final baseUrl = "http://10.0.2.2:8080/api/v1/tutorials";

void main() {
  
  final client = MockClient();
  final mockTutorialLocalRepository  = MockTutorialLocalRepository();
  final enrollementRepository = EnrollementRepository(client, mockTutorialLocalRepository);
  group('EnrollementRepository', () {
    final tutorialId = 1;
    test('returns Tutorial successfully enrolled if http call successfully enrolls the client', () async {
      when(client
              .post(Uri.parse('$baseUrl/$tutorialId/enroll')))
          .thenAnswer((_) async =>
              http.Response("", 204));
      when(mockTutorialLocalRepository.getTutorial(tutorialId)).thenAnswer((realInvocation) => Future.value(tutorial),);
      when(mockTutorialLocalRepository.toggleEnrollement(tutorial)).thenAnswer((realInvocation) => Future.value(1),);
      expect(await enrollementRepository.enroll(tutorialId: tutorialId), "Tutorial successfully enrolled");
    });
     test('returns Unable to enroll if http call fails to enroll the client', () async {
      when(client
              .post(Uri.parse('$baseUrl/$tutorialId/enroll')))
          .thenAnswer((_) async =>
              http.Response("", 400));

      expect(await enrollementRepository.enroll(tutorialId: tutorialId), "Unable to enroll");
    });
    test('returns Tutorial successfully unenrolled if http call successfully unenrolls the client', () async {
      when(client
              .delete(Uri.parse('$baseUrl/enrolled/$tutorialId')))
          .thenAnswer((_) async =>
              http.Response("", 204));

      expect(await enrollementRepository.unenroll(tutorialId: tutorialId), "Tutorial successfully unenrolled");
    });
     test('returns Unable to unenroll if http call unable to unenrolls the client', () async {
      when(client
              .delete(Uri.parse('$baseUrl/enrolled/$tutorialId')))
          .thenAnswer((_) async =>
              http.Response("", 400));

      expect(await enrollementRepository.unenroll(tutorialId: tutorialId), "Unable to unenroll");
    });
  });
}