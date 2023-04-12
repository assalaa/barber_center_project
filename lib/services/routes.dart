import 'package:barber_center/screens/home_screen/home_screen.dart';
import 'package:barber_center/screens/signin_screen/sigin_screen.dart';
import 'package:barber_center/screens/signup_screen/signup_screen.dart';
import 'package:barber_center/screens/splash_screen/splash_screen.dart';
import 'package:barber_center/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  //splash screen
  static const String splashRoute = '/splash';
  static const String welcomeRoute = '/';
  static const String signupRoute = '/signup';
  static const String signinRoute = '/signin';
  static const String homeRoute = '/home';
  static const String salonDetailsRoute = '/salon_details';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUPScreen());
      case signinRoute:
        return MaterialPageRoute(builder: (_) => SignInScreen(kindOfUser: args as String));
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case salonDetailsRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
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

  static void goTo(String route, {bool enableBack = false, args}) {
    debugPrint('GO TO $route');
    Navigator.of(Routes.navigator.currentContext!).pushNamedAndRemoveUntil(
      route,
      arguments: args,
      (route) => enableBack,
    );
  }
}
