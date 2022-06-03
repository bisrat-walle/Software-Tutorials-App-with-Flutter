enum APP_PAGE {
  splash,
  home,
  login,
  signup,
  error,
  profile,
  tutorials,
  tutorialDetail
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {

      case APP_PAGE.home:
        return "/";
      case APP_PAGE.login:
        return "/login";
      case APP_PAGE.splash:
        return "/welcome";
	  case APP_PAGE.signup:
		return "/signup";
	  case APP_PAGE.profile:
		return "/profile";
	  case APP_PAGE.tutorials:
		return "/tutorials/all";
	  case APP_PAGE.tutorialDetail:
		return "tutorials/1";
      case APP_PAGE.error:
        return "/error";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.login:
        return "LOGIN";
      case APP_PAGE.splash:
        return "WELCOME";
	  case APP_PAGE.signup:
		return "SIGNUP";
	  case APP_PAGE.profile:
		return "PROFILE";
	  case APP_PAGE.tutorials:
		return "ALL TUTORIALS";
	  case APP_PAGE.tutorialDetail:
		return "TutorialDetail";
      case APP_PAGE.error:
        return "ERROR";
      default:
        return "HOME";
    }
  }

  String get toTitle {
    switch (this) {
      case APP_PAGE.home:
        return "Software Tutorials - Home";
      case APP_PAGE.login:
        return "Software Tutorials - Login";
      case APP_PAGE.splash:
        return "Software Tutorials - Welcome";
	  case APP_PAGE.signup:
		return "Software Tutorials - Signup";
	  case APP_PAGE.profile:
		return "Software Tutorials - Profile";
	  case APP_PAGE.tutorials:
		return "Software Tutorials - All Tutorials";
	  case APP_PAGE.tutorialDetail:
		return "Software Tutorials - Tutorial Detail";
      case APP_PAGE.error:
        return "/error";
      default:
        return "/";
    }
  }
}

class TutorialPages{
	static String homePath = "/";
	static String loginPath = "/login";
	static String signupPath = "/signup";
	static String profilePath = "/profile";
	static String manageUserPath = "/manage/users";
	static String tutorialDetailPath = "/tutorials";
	static String allTutorialsPath = "/tutorials/all";

}