import 'package:barber_center/screens/profile_screen/customer_profile_screen.dart';
import 'package:barber_center/screens/salon_screen/salon_details_screen.dart';
import 'package:barber_center/main.dart';
import 'package:barber_center/screens/admin/add_service/add_service_screen.dart';
import 'package:barber_center/screens/admin/home/home_admin_screen.dart';
import 'package:barber_center/screens/barber/home_barber_screen/home_barber_screen.dart';
import 'package:barber_center/screens/create_account_screen/create_account_screen.dart';
import 'package:barber_center/screens/home_screen/home_screen.dart';
import 'package:barber_center/screens/login_screen/login_screen.dart';
import 'package:barber_center/screens/salon/home_salon_screen/home_salon_screen.dart';
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
  static const String homeSalonRoute = '/home_salon';
  static const String homeBarberRoute = '/home_barber';
  //addServiceRoute
  static const String addServiceRoute = '/add_service';
  static const String homeAdminRoute = '/home_admin';

  static const String salonDetailsRoute = '/salon_details';
  static const String customerProfileRoute = '/profile_customer';
  static const String saloonProfileRoute = '/profile_saloon';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case salonDetailsRoute:
        return MaterialPageRoute(builder: (_) => const SalonDetailsScreen());
      case customerProfileRoute:
        return MaterialPageRoute(builder: (_) => const CustomerProfileScreen());
      case saloonProfileRoute:
        return MaterialPageRoute(builder: (_) => const CustomerProfileScreen());
      case createAccountRoute:
        return MaterialPageRoute(
            builder: (_) =>
                CreateAccountScreen(kindOfUser: args as KindOfUser));
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(kindOfUser: args as KindOfUser));
      case homeCustomerRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeSalonRoute:
        return MaterialPageRoute(builder: (_) => const HomeSalonScreen());
      case homeBarberRoute:
        return MaterialPageRoute(builder: (_) => const HomeBarberScreen());

      //ADMIN PAGES
      case homeAdminRoute:
        return MaterialPageRoute(builder: (_) => const HomeAdminScreen());
      case addServiceRoute:
        return MaterialPageRoute(builder: (_) => const AddServicePage());
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
