import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/domain/auth/login_response.dart';
import 'package:softwaretutorials/infrastructure/local_repository/tutorial_local_repository.dart';
import 'package:softwaretutorials/infrastructure/local_repository/user_local_repository.dart';

String _baseUrl = "http://10.0.2.2:8080/api/v1/login";

class AuthenticationRepository {
  final client;
  final TutorialLocalRepository tutorialLocalRepository;
  AuthenticationRepository(this.client, this.tutorialLocalRepository);

  Future<bool> authenticateUser({String? username, String? password}) async {
    try {
      final response = await client.post(
        Uri.parse(_baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accept': '*/*'
        },
        body: jsonEncode(
            <String, String?>{'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        LoginResponse res = LoginResponse.fromJson(jsonDecode(response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", res.accessToken!);
        prefs.setString("role", res.role!);
        prefs.setString("username", res.username!);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") != null;
  }

  persistToken(token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", token);
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("username");
    await prefs.remove("role");
    await prefs.remove("tutorialFetched");
    await prefs.remove("usersFetched");
    await tutorialLocalRepository.removeTables();
    return true;
  }
}
