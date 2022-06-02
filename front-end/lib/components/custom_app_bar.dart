import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final tit;
  CustomAppBar({this.tit}) : super(
	backgroundColor: Colors.white,
	title: tit,
	centerTitle: true,
	
	);
}