
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:softwaretutorials/domain/auth/repo_response.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';

import 'tutorial_repository_test.mocks.dart';


final baseUrl = "http://localhost:8080/api/v1";


void main() {
  
  final client = MockClient();
  final profileRepository = ProfileRepository(client);
  group('ProfileRepository', () {
    final tutorialId = 1;
    final userId = 1;
    final userJson = jsonEncode(<String, dynamic>{
          'username': "username",
          'password': "password",
          'fullName': "fullName",
          'role': "role",
          'email': "email",
        });
    final userUpdateJson = jsonEncode(<String, dynamic>{
          'username': "username",
          'password': "password",
          'fullName': "fullName",
          'email': "email",
        });
    test('returns RepoResponse model with no error after successfull signup', () async {
      when(client
              .post(Uri.parse('$baseUrl/register'), body: userJson, headers: <String, String>{
          'Content-Type': 'application/json',
          'accept': '*/*'
        },))
          .thenAnswer((_) async =>
              http.Response(userJson, 201));
      final user = User.fromJson(jsonDecode(userJson));
      final res = await profileRepository.signup(
        email: user.email!, username: user.username!, 
        fullName: user.fullName, 
        password: user.password!, 
        role: user.role!);
      expect(res, isA<RepoResponse>());
      expect(res.error, null);
    });
    test('returns RepoResponse model with error after signup failure', () async {
    when(client
              .post(Uri.parse('$baseUrl/register'), body: userJson, headers: <String, String>{
          'Content-Type': 'application/json',
          'accept': '*/*'
        },))
          .thenAnswer((_) async =>
              http.Response(userJson, 400));
      final user = User.fromJson(jsonDecode(userJson));
      final res = await profileRepository.signup(
        email: user.email!, username: user.username!, 
        fullName: user.fullName, 
        password: user.password!, 
        role: user.role!);
      expect(res, isA<RepoResponse>());
      expect(res.error, isNotNull);
    });
    test('returns RepoResponse model with no error after successfull profile update', () async {
      when(client
              .put(Uri.parse('$baseUrl/profile'), body: userUpdateJson))
          .thenAnswer((_) async =>
              http.Response(userJson, 200));
      final user = User.fromJson(jsonDecode(userJson));
      final res = await profileRepository.updateProfile(
        email: user.email!, username: user.username!, 
        fullName: user.fullName, 
        password: user.password!);
      expect(res, isA<RepoResponse>());
      expect(res.error, null);
    });
    test('returns RepoResponse model with error after profile update failure', () async {
    when(client
              .put(Uri.parse('$baseUrl/profile'), body: userUpdateJson))
          .thenAnswer((_) async =>
              http.Response(userJson, 400));
      final user = User.fromJson(jsonDecode(userJson));
      final res = await profileRepository.updateProfile(
        email: user.email!, username: user.username!, 
        fullName: user.fullName, 
        password: user.password!);
      expect(res, isA<RepoResponse>());
      expect(res.error, isNotNull);
    });


        test('returns true after successfully deleting user', () async {
      when(client
              .delete(Uri.parse('$baseUrl/users/$userId')))
          .thenAnswer((_) async =>
              http.Response(userJson, 204));
      final user = User.fromJson(jsonDecode(userJson));
      expect(await profileRepository.deleteUser(userId), true);
    });
    test('returns false after delete failure', () async {
      when(client
              .delete(Uri.parse('$baseUrl/users/$userId')))
          .thenAnswer((_) async =>
              http.Response(userJson, 400));
      final user = User.fromJson(jsonDecode(userJson));
      expect(await profileRepository.deleteUser(userId), false);
    });
    test('should fetch all users of the app', () async {
      when(client
              .get(Uri.parse('$baseUrl/users/')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode([userJson, userJson, userJson].map((user) => User.fromJson(jsonDecode(user))).toList()), 200));
      final user = User.fromJson(jsonDecode(userJson));
      final res = await profileRepository.getAllUsers();
      expect(res, isA<List<User>>());
      expect(res.length, 3);
    });
  });
}