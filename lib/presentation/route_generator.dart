import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techtime/presentation/screens/ClientApp/home_page.dart';

import 'package:techtime/presentation/screens/startupViews/client_signup_page.dart';
import 'package:techtime/presentation/screens/startupViews/login_moderator_page.dart';
import 'package:techtime/presentation/screens/startupViews/login_page.dart';
import 'package:techtime/presentation/screens/startupViews/sms_verification_screen.dart';
import 'package:techtime/presentation/screens/startupViews/splashScreen_page.dart';

import 'screens/startupViews/language_selection_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/languageSelection':
        return PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: 800),
            child: LanguageSelectionPage());
      case '/loginModerator':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: LoginModeratorPage(),
        );
      case '/login':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 400),
          child: LoginPage(),
        );
      case '/clientRegistration':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 400),
          child: ClientSignupPage(),
        );
      case '/sms':
        return PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 400),
          child: SmsVerification(),
        );
      case '/clientHome':
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: ClientHomePage(),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
