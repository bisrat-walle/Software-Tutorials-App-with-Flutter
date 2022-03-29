import 'package:flutter/material.dart';
import 'routes/login.dart';
import 'routes/signUp.dart';
import 'routes/boot.dart';
import 'routes/clientPage.dart';
import 'routes/instructorPage.dart';
import 'routes/admindashboard.dart';

class RouteGenerator {
  static const String boot = "/";
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String clienPage = "/clienpage";
  static const String instructorPage = "/instructorPage";
  static const String admindashboard = "/admindashboar";
  RouteGenerator._() {}
  static Route<dynamic> routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case boot:
        return MaterialPageRoute(builder: (_) => Boot());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case clienPage:
        return MaterialPageRoute(builder: (_) => const ClientPage());
      case instructorPage:
        return MaterialPageRoute(builder: (_) => const InstructorPage());
      case admindashboard:
        return MaterialPageRoute(builder: (_) => const Admindashdoard());
      default:
        throw Exception("route not found");
    }
  }
}
