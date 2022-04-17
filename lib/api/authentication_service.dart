import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import 'dart:convert';

String _baseUrl = "http://localhost:8080/api/v1";
Future<LoginResponse> authenticateUser({String? username, String? password}) async {
  final client = http.Client();
  final response = await client.post(
    Uri.parse(_baseUrl+"/login"),
    headers: <String, String>{
      'Content-Type': 'application/json',
	  'Accept': 'application/json'
    },
    body: jsonEncode(<String, String?>{
      'username': username,
      'password': password
    }),
  );

  if (response.statusCode == 200) {
    return LoginResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to authenticate!');
  }
}
