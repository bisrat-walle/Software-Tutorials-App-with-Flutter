import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/domain/tutorials/tutorial.dart';
import 'dart:convert';

import 'package:softwaretutorials/infrastructure/local_repository/tutorial_local_repository.dart';


String _baseUrl = "http://10.0.2.2:8080/api/v1/tutorials/";
class TutorialRepository{
  final client;
  late TutorialLocalRepository tutorialLocalRepository;

  TutorialRepository(this.client, this.tutorialLocalRepository);
  Future<List<Tutorial>> getAllTutorials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final alreadyFetched = prefs.get("tutorialFetched") != null;
    if (alreadyFetched){
      return tutorialLocalRepository.getAllTutorials();
    }

    final response = await client.get(
      Uri.parse(_baseUrl+"all/c"),
    );

    if (response.statusCode == 200){
      Iterable response_body = jsonDecode(response.body);
      List<Tutorial> tutorialList = List<Tutorial>.from(
          response_body.map((tutorialItem) => Tutorial.fromJson(tutorialItem)));
      for (int i=0; i < tutorialList.length; i++){
        tutorialLocalRepository.createTutorial(tutorialList[i]);
      }
      prefs.setString("tutorialFetched", "YES");
      return tutorialList;
    } else if (response.statusCode == 403){
		throw Exception("Failed to load");
	}
    return [];
  }

  Future<Tutorial?> getTutorial(int tutorialId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final alreadyFetched = prefs.get("tutorialFetched") != null;
    if (alreadyFetched){
      return tutorialLocalRepository.getTutorial(tutorialId);
    }


    final response = await client.get(
      Uri.parse(_baseUrl+tutorialId.toString()),
    );

    if (response.statusCode == 200){
      return Tutorial.fromJson(jsonDecode(response.body));
    }

  }
  
   Future<List<Tutorial>> getEnrolledTutorials() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Tutorial> list = [];
    final alreadyFetched = prefs.get("tutorialFetched") != null;
    if (alreadyFetched){
      final  allList = await tutorialLocalRepository.getAllTutorials();
      for (int i=0; i < allList.length; i++){
        if (allList[i].enrolled!){
          list.add(allList[i]);
        }
      }
      return list;
    }

    final response = await client.get(
      Uri.parse(_baseUrl+"enrolled"),
    );
    if (response.statusCode == 200){
      Iterable response_body = jsonDecode(response.body);
      List<Tutorial> tutorialList = List<Tutorial>.from(
          response_body.map((tutorialItem) => Tutorial.fromJson(tutorialItem)));
      return tutorialList;
    } else if (response.statusCode == 403){
      throw Exception("failed to fetch");
	}
    return [];
  }
  
  Future<List<Tutorial>> getMyTutorials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.get("username");
    List<Tutorial> list = [];
    final alreadyFetched = prefs.get("tutorialFetched") != null;
    if (alreadyFetched){
      final  allList = await tutorialLocalRepository.getAllTutorials();
      for (int i=0; i < allList.length; i++){
        if (allList[i].instructor!.username! == username){
          list.add(allList[i]);
        }
      }
      return list;
    }

    final response = await client.get(
      Uri.parse(_baseUrl+"mytutorials"),
    );
    if (response.statusCode == 200){
      Iterable response_body = jsonDecode(response.body);
      List<Tutorial> tutorialList = List<Tutorial>.from(
          response_body.map((tutorialItem) => Tutorial.fromJson(tutorialItem)));
      return tutorialList;
    } else if (response.statusCode == 403){
		throw Exception("Failed to load");
	}
    return [];
  }

  Future<bool> createTutorial(
      {required String title,
        required String content,
        required String projectTitle,
        required String problemStatement}) async {
    try {
      final response = await client.post(
        Uri.parse(_baseUrl),
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'content': content,
          'project': {
            'title': projectTitle,
            'problemStatement': problemStatement,
          }
        }),
      );

      if (response.statusCode == 201) {
        await tutorialLocalRepository.createTutorial(Tutorial.fromJson(jsonDecode(response.body)));
        return true;
      } else if (response.statusCode == 403){
		throw Exception("Failed to load");
	  }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTutorial(
      {required String title,
        required String content,
        required String projectTitle,
        required String problemStatement,
        required int tutorialId}) async {
    try {
      final response = await client.put(
        Uri.parse(_baseUrl + tutorialId.toString()),
        body: jsonEncode(<String, dynamic?>{
          'title': title,
          'content': content,
          'project': {
            'title': projectTitle,
            'problemStatement': problemStatement,
          }
        }),
      );
      if (response.statusCode == 200) {
        await tutorialLocalRepository.updateTutorial(Tutorial.fromJson(jsonDecode(response.body)));
        return true;
      } else if (response.statusCode == 403){
		throw Exception("Failed to load");
	  }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTutorial({required int tutorialId}) async {
    try {
      final response = await client.delete(
        Uri.parse(_baseUrl + tutorialId.toString()),
      );

      if (response.statusCode == 204) {
        await tutorialLocalRepository.deleteTutorial(tutorialId);
        return true;
      } else if (response.statusCode == 403){
		throw Exception("Failed to load");
	  }
      return false;
    } catch (e) {
      return false;
    }
  }

}
