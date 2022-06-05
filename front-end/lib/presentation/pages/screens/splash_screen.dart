
import 'package:flutter/material.dart';
import 'package:softwaretutorials/domain/core/models.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
		child: Scaffold(
      body: Container(
		color: Colors.purple,
		child: Center(
            child: Image.asset("assets/images/logo.png"),
          
        ),
	  ),
    ),
	);
  }
}