import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/domain/auth/repo_response.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'dart:convert';

import 'package:softwaretutorials/infrastructure/local_repository/user_local_repository.dart';

String _baseUrl = "http://10.0.2.2:8080/api/v1/";

class ProfileRepository {
  final client;
  final UserLocalRepository userLocalRepository;

  ProfileRepository(this.client, this.userLocalRepository);
  Future<RepoResponse> signup(
      {required String email,
      required String username,
      required fullName,
      required String password,
      required String role}) async {
    final response = await client.post(Uri.parse(_baseUrl + "register"),
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
        }));
    if (response.statusCode == 201) {
      return RepoResponse(true);
    } else if (response.statusCode == 409) {
      final error = jsonDecode(response.body)["fullName"];
      print("Error $error");
      if (error != null) return RepoResponse(false, error: error);
    }
    return RepoResponse(false, error: "Unknown Error (try again)");
  }

  Future<RepoResponse> updateProfile(
      {required String email,
      required String username,
      required fullName,
      required String password}) async {
    final response = await client.put(Uri.parse(_baseUrl + "profile"),
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'fullName': fullName,
          'email': email,
        }));
    if (response.statusCode == 200) {
      return RepoResponse(true);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body)["fullName"];
      if (error != null) {
        return RepoResponse(false, error: error);
      }
    }
    return RepoResponse(false, error: "Unknown Error (try again)");
  }

  Future<List<User>> getAllUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final alreadyFetched = prefs.get("usersFetched") != null;

    if (alreadyFetched) {
      return await userLocalRepository.getAllUsers();
    }

    final response = await client.get(
      Uri.parse(_baseUrl + "users/"),
    );

    if (response.statusCode == 200) {
      Iterable response_body = jsonDecode(response.body);
      List<User> userList =
          List<User>.from(response_body.map((user) => User.fromJson(user)));
      for (int i = 0; i < userList.length; i++) {
        await userLocalRepository.createUser(userList[i]);
      }
      prefs.setString("usersFetched", "YES");
      return userList;
    }
    return [];
  }

  Future<bool> deleteUser(String username) async {
    final response =
        await client.delete(Uri.parse(_baseUrl + "users/" + username));
    if (response.statusCode == 200) {
      await userLocalRepository.deleteUser(username);
      return true;
    }
    return false;
  }

  Future<User?> getUserProfile() async {
    final response = await client.get(Uri.parse(_baseUrl + "profile/"));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
  }
}
