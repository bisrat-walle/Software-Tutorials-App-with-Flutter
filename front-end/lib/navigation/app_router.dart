import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/screens.dart';

// 1
class AppRouter extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin{ 
	@override
	final GlobalKey<NavigatorState> navigatorKey;
	// 3
	final AppStateManager appStateManager;
	// 5
	// final ProfileManager profileManager;
	AppRouter({
	required this.appStateManager,
	// required this.profileManager,
	}) : navigatorKey = GlobalKey<NavigatorState>() {
		appStateManager.addListener(notifyListeners);
	}
	// TODO: Dispose listeners
	// 6
	@override
	Widget build(BuildContext context) {
		// 7
		return Navigator(
		// 8
		key: navigatorKey,
		onPopPage: _handlePopPage,
		pages: [
			if(!appStateManager.isInitialized) SplashScreen.page(),
			if(appStateManager.isInitialized && !appStateManager.isLoggedIn) LoginScreen.page(),
			if(appStateManager.isLoggedIn) TutorialScreen.page(),
			// TODO: Add OnboardingScreen
			// TODO: Add Home
			// TODO: Create new item
			// TODO: Select GroceryItemScreen
			// TODO: Add Profile Screen
			// TODO: Add WebView Screen
		],
		);
	}
	
	bool _handlePopPage(
		// 1
		Route<dynamic> route,
		// 2
		result) {
			// 3
		if(!route.didPop(result)) {
			// 4
			return false;
		}
		// 5
		// TODO: Handle Onboarding and splash
		// TODO: Handle state when user closes grocery item screen
		// TODO: Handle state when user closes profile screen
		// TODO: Handle state when user closes WebView screen
		// 6
		return true;
	}
	
	@override
	void dispose() {
		appStateManager.removeListener(notifyListeners);
		super.dispose();
	}
	
	// 10
	@override
	Future<void> setNewRoutePath(configuration) async=> null;
}