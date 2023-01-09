import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softwaretutorials/presentation/pages/screens/screens.dart';

void main() {
  testWidgets('Splash Screen Test: should contain logo and not text',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SplashScreen(),
    ));

    expect(
        find.image(const AssetImage("assets/images/logo.png")), findsOneWidget);
    expect(find.text("hello"), findsNothing);
  });
}
