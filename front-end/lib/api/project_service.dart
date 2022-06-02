import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:softwaretutorials/api/token_interceptor.dart';
import 'dart:convert';
import '../models/tutorial.dart';

String _baseUrl = "http://localhost:8080/api/v1/tutorials/";

http.Client client = InterceptedClient.build(interceptors: [
	TokenInterceptor(),
]);

class ProjectService{

	static Future<bool> createProject({required int tutorialId, required String projectUrl}) async {
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


	static Future<bool> updateProject({required int tutorialId, required String projectUrl}) async {
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

	static Future<bool> deleteProject({required int tutorialId}) async {
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