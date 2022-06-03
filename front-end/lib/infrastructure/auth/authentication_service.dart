import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/domain/auth/login_response.dart';


String _baseUrl = "http://localhost:8080/api/v1/login";
class AuthenticationRepository {
  static 
  Future<bool> authenticateUser({String? username, String? password}) async {
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
      LoginResponse res = LoginResponse.fromJson(jsonDecode(response.body));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", res.accessToken!);
      prefs.setString("role", res.role!);
      prefs.setString("username", res.username!);
      return true;
      }
      return false;
    } catch(e){
    print(e);
    return false;
    }
  }

  static Future<bool> getLoginStatus() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") != null;
  }

  static persistToken(token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", token);
  }

  static logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("username");
    prefs.remove("role");
    return true;
  }

}