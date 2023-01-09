import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softwaretutorials/presentation/pages/components/components.dart';

void main() {
  testWidgets('Drawer should not contain logout', (WidgetTester tester) async {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(
          "Home",
        ),
      ),
      drawer: Builder(builder: (context) {
        return CustomDrawer.get(context);
      }),
    )));
    await tester.pumpAndSettle();
    _key.currentState!.openDrawer();
    expect(find.text("hello"), findsNothing);
  });
}
