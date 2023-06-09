import 'package:barber_center/screens/home_screen/home_screen.dart';
import 'package:barber_center/screens/signin_screen/sigin_screen.dart';
import 'package:barber_center/screens/signup_screen/signup_screen.dart';
import 'package:barber_center/screens/welcome_sceen/welcome_screen.dart';
import 'package:barber_center/services/constants.dart';
import 'package:flutter/material.dart';

import '../screens/salon_screen/salon_details_screen.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUPScreen());
      case signinRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case salonDetailsRoute:
        return MaterialPageRoute(builder: (_) => const SalonDetailsScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

  static final navigator = GlobalKey<NavigatorState>();
  static goTo(String route, {bool enableBack = false, args}) {
    debugPrint('GO TO $route');
    Navigator.of(Routes.navigator.currentContext!).pushNamedAndRemoveUntil(
      route,
      arguments: args,
      (Route<dynamic> route) => enableBack,
    );
  }
}
