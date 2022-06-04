import 'dart:convert';


String _baseUrl = "http://localhost:8080/api/v1/tutorials/";

class ProjectRepository{

  final client;

  ProjectRepository(this.client);

	Future<bool> createProject({required int tutorialId, required String projectUrl}) async {
		try{
			final response = await client.post(
				Uri.parse(_baseUrl+tutorialId.toString()+"/project"),
				body: jsonEncode(<String, String?>{
					'projectUrl': projectUrl
				}),
			);

			if (response.statusCode == 201) {
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
				return true;
			}
			return false;
		} catch(e){
			print(e);
			return false;
		}
	}

}