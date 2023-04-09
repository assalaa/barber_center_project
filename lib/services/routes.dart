import 'package:barber_center/screens/home_screen/home_screen.dart';
import 'package:barber_center/screens/signup_screen/signup_screen.dart';
import 'package:barber_center/screens/welcome_sceen/welcome_screen.dart';
import 'package:barber_center/services/constants.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUPScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
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
}
