import 'package:flutter/material.dart';
import 'home.dart';
import 'screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(Home(sharedPreferences: sharedPreferences));
}
