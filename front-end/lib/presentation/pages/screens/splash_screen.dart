import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softwaretutorials/domain/core/models.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static MaterialPage page() {
	return MaterialPage(
		name: TutorialPages.homePath,
		key: ValueKey(TutorialPages.homePath),
		child: SplashScreen(),
		);
	}
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
  }
 
 
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