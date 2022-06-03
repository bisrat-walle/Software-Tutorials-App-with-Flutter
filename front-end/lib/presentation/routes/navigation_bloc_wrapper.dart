import 'dart:async';
import 'package:flutter/material.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';

class NavigationStateWrapper extends ChangeNotifier {
	late final _navigationStream;
	
	NavigationStateWrapper(NavigationBloc bloc) {
		_navigationStream = bloc.stream.listen( (event) {
			notifyListeners();
		});
	}
	
	@override
	void dispose() {
		super.dispose();
		_navigationStream.cancel();
	}
}