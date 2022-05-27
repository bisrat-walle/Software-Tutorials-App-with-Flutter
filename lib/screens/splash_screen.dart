import 'dart:async';

import 'package:flutter/material.dart';
import 'package:softwaretutorials/screens/screens.dart';
import 'login_screen.dart';
import 'package:softwaretutorials/models/models.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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


