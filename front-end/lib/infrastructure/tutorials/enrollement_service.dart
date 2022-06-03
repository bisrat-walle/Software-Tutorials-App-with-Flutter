import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'dart:convert';

import 'package:softwaretutorials/infrastructure/repositories/token_intercepter.dart';

String _baseUrl = "http://localhost:8080/api/v1/tutorials/";

http.Client client = InterceptedClient.build(interceptors: [
	TokenInterceptor(),
]);

class EnrollementService{

	static Future<String?> enroll({required int tutorialId}) async {
		try{
			final response = await client.post(
					Uri.parse(_baseUrl+tutorialId.toString()+"/enroll")
			);

			if (response.statusCode == 204) {
				return "Course successfully enrolled";
			}
		} catch(e){
			print(e);
			return "Unable to enroll";
		}
	}

	static Future<String?> unenroll({required int tutorialId}) async {
		try{
			final response = await client.delete(
					Uri.parse(_baseUrl+"enrolled/"+tutorialId.toString())
			);

			if (response.statusCode == 204) {
				return "Course successfully unenrolled";
			}
		} catch(e){
			print(e);
			return "Unable to unenroll";
		}
	}

}