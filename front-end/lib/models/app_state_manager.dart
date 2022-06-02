import 'dart:async';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/models.dart';

class TutorialTab{
	static const int explore = 0;
	static const int enrolled = 1;
	static const int mytutorials = 2;
}
class AppStateManager extends ChangeNotifier{
    AppStateManager({this.sharedPreferences});
    final sharedPreferences;
	bool _initialized = false;
	bool _loggedIn = false;
	bool _onboardingComplete = false;
	String? _loginError;
	bool _isSignupState = false;
	late GlobalKey<FormState> createTutorialFormKey;
	int tutorialId = -1;
	Tutorial? tutorial;
	
	late TextEditingController titleController;
	late TextEditingController contentController;
	late TextEditingController projectTitleController;
	late TextEditingController problemStatementController;
	
	initializeControllers(){
	    createTutorialFormKey = GlobalKey<FormState>();
		titleController = TextEditingController();
		contentController = TextEditingController();
		projectTitleController = TextEditingController();
		problemStatementController = TextEditingController();
		if (tutorial != null){
			titleController.text = tutorial!.title!;
			contentController.text = tutorial!.content!;
			projectTitleController.text = tutorial!.project!.title!;
			problemStatementController.text = tutorial!.project!.problemStatement!;
			tutorialId = tutorial!.tutorialId!;
		}
	}
	
	destroyControllers(){
		titleController.dispose();
		contentController.dispose();
		projectTitleController.dispose();
		problemStatementController.dispose();
	}
	
	int _selectedTab = TutorialTab.explore;
	
	
	bool get isSignupState => _isSignupState;
	bool get isInitialized => _initialized;
	bool get isLoggedIn => sharedPreferences.get("token") != null;
	bool get isOnboardingComplete => _onboardingComplete;
	int get getSelectedTab => _selectedTab;
	String? get getLoginError => _loginError;
	
	void gotoSignup(){
		_isSignupState = true;
		notifyListeners();
	}
	
	void popSignup(){
		_isSignupState = false;
		notifyListeners();
	}
	
	void initializeApp() {
		Timer(const Duration(milliseconds: 2000), () {
			_initialized = true;
			notifyListeners();
			},
		);
	}
	
	
	
	// Login
	
	void login({required String username, required String password}) async {
		_loggedIn = await authenticateUser(
		  username: username,
		  password: password
		);
		
		notifyListeners();
	}
	
	// CompleteOnboarding
	
	void completeOnboarding() {
		_onboardingComplete = true;
		notifyListeners();
	}
	
	// GoToTab
	
	void goToTab(index) {
		_selectedTab = index;
		notifyListeners();
	}
	
	void goToEnrolledTab(){
		_selectedTab = TutorialTab.enrolled;
		notifyListeners();
	}
	
	// Logout
	void logout() {
		sharedPreferences.remove("token");
		_loggedIn = false;
		_onboardingComplete = false;
		_initialized = false;
		_selectedTab = 0;
		initializeApp();
		notifyListeners();
	}

}