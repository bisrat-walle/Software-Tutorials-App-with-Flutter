import 'dart:convert';

import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/infrastructure/local_repository/tutorial_local_repository.dart';


String _baseUrl = "http://10.0.2.2:8080/api/v1/tutorials/";

class ProjectRepository{

  final client;
  final TutorialLocalRepository tutorialLocalRepository;

  ProjectRepository(this.client, this.tutorialLocalRepository);
  

	Future<bool> createProject({required int tutorialId, required String projectUrl}) async {
		try{
			final response = await client.post(
				Uri.parse(_baseUrl+tutorialId.toString()+"/project"),
				body: jsonEncode(<String, String?>{
					'projectUrl': projectUrl
				}),
			);
			if (response.statusCode == 204) {
        Tutorial tutorial = await tutorialLocalRepository.getTutorial(tutorialId);
        tutorial.submittedLink = projectUrl;
        await tutorialLocalRepository.submitProject(tutorial);
				return true;
			}
			return false;
		} catch(e){
			print(e);
			return false;
		}
	}


	Future<bool> updateProject({required int tutorialId, required String projectUrl}) async {
		try{
			final response = await client.put(
				Uri.parse(_baseUrl+tutorialId.toString()+"/project"),
				body: jsonEncode(<String, String?>{
					'projectUrl': projectUrl
				}),
			);

			if (response.statusCode == 204) {
        Tutorial tutorial = await tutorialLocalRepository.getTutorial(tutorialId);
        tutorial.submittedLink = projectUrl;
        await tutorialLocalRepository.submitProject(tutorial);
				return true;
			}
			return false;
		} catch(e){
			print(e);
			return false;
		}
	}

	Future<bool> deleteProject({required int tutorialId}) async {
		try{
			final response = await client.delete(
				Uri.parse(_baseUrl+tutorialId.toString()+"/project"),
			);

			if (response.statusCode == 204) {
        Tutorial tutorial = await tutorialLocalRepository.getTutorial(tutorialId);
        tutorial.submittedLink = null;
        await tutorialLocalRepository.submitProject(tutorial);
				return true;
			}
			return false;
		} catch(e){
			print(e);
			return false;
		}
	}

}