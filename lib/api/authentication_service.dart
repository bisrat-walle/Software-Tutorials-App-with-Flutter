import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import 'dart:convert';

String _baseUrl = "http://localhost:8080/api/v1/login";
Future<LoginResponse?> authenticateUser({String? username, String? password}) async {
  try{
		final response = await http.post(
		Uri.parse(_baseUrl),
		headers: <String, String>{
		  'Content-Type': 'application/json',
		  'accept': '*/*'
		},
		body: jsonEncode(<String, String?>{
		  'username': username,
		  'password': password
		}),
	  );
	
	  if (response.statusCode == 200) {
		return LoginResponse.fromJson(jsonDecode(response.body));
	  }
  } catch(e){
	print(e);
  }
}
