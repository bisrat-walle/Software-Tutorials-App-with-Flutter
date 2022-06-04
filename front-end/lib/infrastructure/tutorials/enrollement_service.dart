


String _baseUrl = "http://localhost:8080/api/v1/tutorials/";

class EnrollementRepository{
  final client;

  EnrollementRepository(this.client);
	Future<String?> enroll({required int tutorialId}) async {
		try{
			final response = await client.post(
					Uri.parse(_baseUrl+tutorialId.toString()+"/enroll")
			);

			if (response.statusCode == 204) {
				return "Tutorial successfully enrolled";
			}
		} catch(e){
		}
			return "Unable to enroll";
	}

	Future<String?> unenroll({required int tutorialId}) async {
		try{
			final response = await client.delete(
					Uri.parse(_baseUrl+"enrolled/"+tutorialId.toString())
			);

			if (response.statusCode == 204) {
				return "Tutorial successfully unenrolled";
			}
		} catch(e){
		}
			return "Unable to unenroll";
	}

}