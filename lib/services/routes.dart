import 'package:barber_center/main.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/screens/admin/create_service/create_service_screen.dart';
import 'package:barber_center/screens/admin/home/home_admin_screen.dart';
import 'package:barber_center/screens/barber/options/barber_options_screen.dart';
import 'package:barber_center/screens/booking_screen/booking_screen.dart';
import 'package:barber_center/screens/create_account_screen/create_account_screen.dart';
import 'package:barber_center/screens/first_page/first_page_barber/first_page_barber_user.dart';
import 'package:barber_center/screens/first_page/first_page_customer/first_page_customer_user.dart';
import 'package:barber_center/screens/first_page/first_page_salon/first_page_salon_user.dart';
import 'package:barber_center/screens/location_screen/location_screen.dart';
import 'package:barber_center/screens/login_screen/login_screen.dart';
import 'package:barber_center/screens/profile_customer_screen/profile_customer_screen.dart';
import 'package:barber_center/screens/profile_salon_screen/add_service/add_service_screen.dart';
import 'package:barber_center/screens/profile_salon_screen/profile_salon_screen.dart';
import 'package:barber_center/screens/salon_details_screen/salon_details_screen.dart';
import 'package:barber_center/screens/salon_options_screen/salon_options_screen.dart';
import 'package:barber_center/screens/search_screen/search_screen.dart';
import 'package:barber_center/screens/splash_screen/splash_screen.dart';
import 'package:barber_center/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  //splash screen
  static const String splashRoute = '/splash';
  static const String welcomeRoute = '/';
  static const String createAccountRoute = '/create_account';
  static const String salonOptionsRoute = '/salon_options';
  static const String barberOptionsRoute = '/barber_options';
  static const String loginRoute = '/login';
  static const String homeCustomerRoute = '/home_customer';
  static const String homeSalonRoute = '/home_salon';
  static const String homeBarberRoute = '/home_barber';
  static const String createServiceRoute = '/create_service';
  static const String homeAdminRoute = '/home_admin';
  static const String salonDetailsRoute = '/salon_details';
  static const String customerProfileRoute = '/profile_customer';
  static const String saloonProfileRoute = '/profile_saloon';
  static const String addEmployeeRoute = '/add_employee';
  static const String addServiceRoute = '/add_service';
  static const String bookingRoute = '/booking';
  static const String allSalonsRoute = '/all_salons';
  static const String locationRoute = '/location';
  static const String searchRoute = '/search';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case salonDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => SalonDetailsScreen(uid: args as String));
      case customerProfileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileCustomerScreen());
      case saloonProfileRoute:
        return MaterialPageRoute(builder: (_) => const SaloonProfileScreen());
      // case addEmployeeRoute:
      //   return MaterialPageRoute(builder: (_) => const AddEmployeePage());
      case addServiceRoute:
        return MaterialPageRoute(builder: (_) => const AddServicePage());
      case createAccountRoute:
        return MaterialPageRoute(
            builder: (_) =>
                CreateAccountScreen(kindOfUser: args as KindOfUser));
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(kindOfUser: args as KindOfUser));
      case salonOptionsRoute:
        return MaterialPageRoute(builder: (_) => const SalonOptionsScreen());
      case barberOptionsRoute:
        return MaterialPageRoute(builder: (_) => const BarberOptionsScreen());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeCustomerRoute:
        return MaterialPageRoute(builder: (_) => const FirstPageCustomerUser());
      case homeSalonRoute:
        return MaterialPageRoute(builder: (_) => const FirstPageSalonUser());
      case homeBarberRoute:
        return MaterialPageRoute(builder: (_) => const FirstPageBarberUser());
      case bookingRoute:
        return MaterialPageRoute(
            builder: (_) => BookingScreen(
                  salonService: (args as List)[0] as SalonServiceModel,
                  salonInformation: (args)[1] as SalonInformationModel,
                  barberModel: (args)[2] as BarberModel,
                ));
      //ADMIN PAGES
      case homeAdminRoute:
        return MaterialPageRoute(builder: (_) => const HomeAdminScreen());
      case createServiceRoute:
        return MaterialPageRoute(builder: (_) => const CreateServicePage());
      // Location
      case locationRoute:
        return MaterialPageRoute(builder: (_) => const LocationScreen());

      case searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

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

  static Future<dynamic> goToAndBringValue(String route) async {
    debugPrint('GO TO $route to bring value');
    return await Navigator.of(Routes.navigator.currentContext!)
        .pushNamedAndRemoveUntil(route, (route) => true)
        .then((value) => value);
  }

  static void back({bool returnDialog = false}) {
    debugPrint('GO BACK <- ${returnDialog ? 'return $returnDialog' : ''}');
    if (Navigator.canPop(Routes.navigator.currentContext!)) {
      Navigator.pop(Routes.navigator.currentContext!, returnDialog);
    }
  }
}
