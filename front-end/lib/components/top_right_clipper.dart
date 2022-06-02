import 'package:flutter/material.dart';

class TopRightClipper extends CustomClipper<Path> {
  @override
	Path getClip(Size size) {
	Path path = Path();
	final double _xScaling = size.width / 414;
	final double _yScaling = size.height / 896;
	path.lineTo(107.411 * _xScaling,249.559 * _yScaling);
	path.cubicTo(79.4085 * _xScaling,249.338 * _yScaling,50.9382 * _xScaling,222.114 * _yScaling,31.2975 * _xScaling,201.726 * _yScaling,);
	path.cubicTo(11.6569 * _xScaling,181.339 * _yScaling,0.749904 * _xScaling,153.812 * _yScaling,0.97599 * _xScaling,125.201 * _yScaling,);
	path.cubicTo(1.20208 * _xScaling,96.5899 * _yScaling,12.5427 * _xScaling,69.2388 * _yScaling,32.5031 * _xScaling,49.1643 * _yScaling,);
	path.cubicTo(52.4635 * _xScaling,29.0898 * _yScaling,79.4085 * _xScaling,0.611982 * _yScaling,107.411 * _xScaling,0.833255 * _yScaling,);
	path.cubicTo(107.411 * _xScaling,0.833255 * _yScaling,106.558 * _xScaling,126.035 * _yScaling,106.558 * _xScaling,126.035 * _yScaling,);
	path.cubicTo(106.558 * _xScaling,126.035 * _yScaling,107.411 * _xScaling,249.559 * _yScaling,107.411 * _xScaling,249.559 * _yScaling,);
	path.cubicTo(107.411 * _xScaling,249.559 * _yScaling,107.411 * _xScaling,249.559 * _yScaling,107.411 * _xScaling,249.559 * _yScaling,);
	return path;
	}
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
  