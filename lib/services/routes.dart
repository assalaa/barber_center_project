import 'package:barber_center/screens/admin/home_admin_screen/home_admin_screen.dart';
import 'package:barber_center/screens/barber/home_barber_screen/home_barber_screen.dart';
import 'package:barber_center/screens/create_account_screen/create_account_screen.dart';
import 'package:barber_center/screens/home_screen/home_screen.dart';
import 'package:barber_center/screens/login_screen/login_screen.dart';
import 'package:barber_center/screens/salon_screen/salon_details_screen.dart';
import 'package:barber_center/screens/splash_screen/splash_screen.dart';
import 'package:barber_center/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  //splash screen
  static const String splashRoute = '/splash';
  static const String welcomeRoute = '/';
  static const String createAccountRoute = '/create_account';
  static const String loginRoute = '/login';
  static const String homeCustomerRoute = '/home_customer';
  static const String homeAdminRoute = '/home_admin';
  static const String homeBarberRoute = '/home_barber';

  static const String salonDetailsRoute = '/salon_details';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case createAccountRoute:
        return MaterialPageRoute(builder: (_) => CreateAccountScreen(kindOfUser: args as String));
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen(kindOfUser: args as String));
      case homeCustomerRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case salonDetailsRoute:
        return MaterialPageRoute(builder: (_) => const SalonDetailsScreen());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeAdminRoute:
        return MaterialPageRoute(builder: (_) => const HomeAdminScreen());
      case homeBarberRoute:
        return MaterialPageRoute(builder: (_) => const HomeBarberScreen());
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
