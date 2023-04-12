import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await initFirebase();
      checkNextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> initFirebase() async {
    await DBAuth().initializeFirebase();
  }

  void checkNextScreen() {
    String nextRoute = Routes.welcomeRoute;
    if (DBAuth().isUserLoggedIn) {
      nextRoute = Routes.homeRoute;
    }
    Routes.goTo(nextRoute);
  }
}
