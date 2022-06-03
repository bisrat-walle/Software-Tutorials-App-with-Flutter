import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:softwaretutorials/domain/auth/repo_response.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'dart:convert';

import 'package:softwaretutorials/infrastructure/core/token_interceptor.dart';


String _baseUrl = "http://localhost:8080/api/v1/";

http.Client client = InterceptedClient.build(interceptors: [
  TokenInterceptor(),
]);

class ProfileRepository{
  static Future<RepoResponse> signup({required String email,required String username, required fullName, required String password, required String role}) async {
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
      return RepoResponse(true);
    } else if (response.statusCode == 409){
      final error = jsonDecode(response.body)["fullName"];
      print("Error $error");
      if (error != null)
        return RepoResponse(false, error: error);

    }
    return RepoResponse(false, error: "Unknown Error (try again)");
  }
  static Future<RepoResponse> updateProfile ({required String email,required String username, required fullName, required String password}) async {
    final response = await client.put(
        Uri.parse(_baseUrl+"profile"),
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'fullName': fullName,
          'email': email,
        })

    );
    if (response.statusCode == 200){
      return RepoResponse(true);
    } else if (response.statusCode == 400){
      final error = jsonDecode(response.body)["fullName"];
      if (error != null) {
        return RepoResponse(false, error: error);
      }
    }
    return RepoResponse(false, error: "Unknown Error (try again)");
  }

  static Future<List<User>> getAllUsers() async {
    final response = await client.get(
        Uri.parse(_baseUrl+"users/"),
    );
    
    if(response.statusCode == 200){
      Iterable response_body = jsonDecode(response.body);
      List<User> userList = List<User>.from(
          response_body.map((user) => User.fromJson(user)));
      return userList;
    }
    return [];
  }

  static Future<bool> deleteUser(int userId) async {
    final response = await client.delete(
      Uri.parse(_baseUrl+"users/"+userId.toString())
    );
    if (response.statusCode == 204){
      return true;
    }
    return false;
  }

  static Future<User?> getUserProfile() async {
    final response = await client.get(
      Uri.parse(_baseUrl+"profile/")
    );
    if (response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }
  }
}