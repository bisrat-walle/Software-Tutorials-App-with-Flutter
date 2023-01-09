import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/infrastructure/local_repository/tutorial_local_repository.dart';

String _baseUrl = "http://10.0.2.2:8080/api/v1/tutorials/";

class EnrollementRepository {
  final client;
  final TutorialLocalRepository tutorialLocalRepository;

  EnrollementRepository(this.client, this.tutorialLocalRepository);
  Future<String?> enroll({required int tutorialId}) async {
    try {
      final response = await client
          .post(Uri.parse(_baseUrl + tutorialId.toString() + "/enroll"));

      if (response.statusCode == 204) {
        Tutorial tutorial =
            await tutorialLocalRepository.getTutorial(tutorialId);
        tutorial.enrolled = true;
        tutorial.enrollementCount = tutorial.enrollementCount! + 1;
        await tutorialLocalRepository.toggleEnrollement(tutorial);
        return "Tutorial successfully enrolled";
      }
    } catch (e) {}
    return "Unable to enroll";
  }

  Future<String?> unenroll({required int tutorialId}) async {
    try {
      final response = await client
          .delete(Uri.parse(_baseUrl + "enrolled/" + tutorialId.toString()));

      if (response.statusCode == 204) {
        final tutorial = await tutorialLocalRepository.getTutorial(tutorialId);
        tutorial.enrolled = false;
        tutorial.enrollementCount = tutorial.enrollementCount! - 1;
        await tutorialLocalRepository.toggleEnrollement(tutorial);
        return "Tutorial successfully unenrolled";
      }
    } catch (e) {}
    return "Unable to unenroll";
  }
}
