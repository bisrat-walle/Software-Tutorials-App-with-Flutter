import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  TutorialApp();
}

class TutorialApp extends StatelessWidget {
  const TutorialApp();
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: RouteGenerator.boot,
        onGenerateRoute: RouteGenerator.routeGenerate);
  }
}
