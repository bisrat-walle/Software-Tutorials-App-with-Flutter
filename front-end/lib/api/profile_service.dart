import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:softwaretutorials/api/token_interceptor.dart';
import 'dart:convert';
import '../models/tutorial.dart';

String _baseUrl = "http://localhost:8080/api/v1/";

http.Client client = InterceptedClient.build(interceptors: [
  TokenInterceptor(),
]);

class ProfileService{
  static Future<bool?> signup({required String email,required String username, required fullName, required String password, required String role}) async {
    final response = await http.post(
        Uri.parse(_baseUrl+"register"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accept': '*/*'
        },
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'fullName': fullName,
          'role': role,
          'email': email,
        })

    );
    if (response.statusCode == 201){
      return true;
    }
    return false;
  }
  static Future<bool?> updateProfile ({required String email,required String username, required fullName, required String password, required String role}) async {
    final response = await client.put(
        Uri.parse(_baseUrl+"profile"),
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'fullName': fullName,
          'role': role,
          'email': email,
        })

    );
    if (response.statusCode == 200){
      return true;
    }
    return false;
  }
}