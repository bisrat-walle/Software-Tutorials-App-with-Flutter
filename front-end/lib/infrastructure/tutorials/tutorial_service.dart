import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softwaretutorials/domain/tutorials/tutorial.dart';
import 'dart:convert';

import 'package:softwaretutorials/infrastructure/core/token_interceptor.dart';

String _baseUrl = "http://localhost:8080/api/v1/tutorials/";
class TutorialRepository{
  final client;

  TutorialRepository(this.client);
  Future<List<Tutorial>> getAllTutorials() async {
    final response = await client.get(
      Uri.parse(_baseUrl+"all/c"),
    );

    if (response.statusCode == 200){
      Iterable response_body = jsonDecode(response.body);
      List<Tutorial> tutorialList = List<Tutorial>.from(
          response_body.map((tutorialItem) => Tutorial.fromJson(tutorialItem)));
      print(tutorialList);
      return tutorialList;
    } else if (response.statusCode == 403){
		throw Exception("Failed to load");
	}
    return [];
  }

  Future<Tutorial?> getTutorial(int tutorialId) async {
    final response = await client.get(
      Uri.parse(_baseUrl+tutorialId.toString()),
    );

    if (response.statusCode == 200){
      return Tutorial.fromJson(jsonDecode(response.body));
    }

  }
  
   Future<List<Tutorial>> getEnrolledTutorials() async {
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
	print("trying to fetch my tutorials");
    final response = await client.get(
      Uri.parse(_baseUrl+"mytutorials"),
    );
	print("My tutorials fetched with statusCode ${response.statusCode}");
    if (response.statusCode == 200){
      print("my tutorials 200 status code");
      Iterable response_body = jsonDecode(response.body);
      List<Tutorial> tutorialList = List<Tutorial>.from(
          response_body.map((tutorialItem) => Tutorial.fromJson(tutorialItem)));
      print(tutorialList);
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
      if (response.statusCode == 201) {
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
