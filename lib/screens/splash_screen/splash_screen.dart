import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/main.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../database/db_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () async {
      await initFirebase();
      checkNextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 15, 17, 1),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(Assets.icon),
          ),
        ],
      ),
    );
  }

  Future<void> initFirebase() async {
    await DatabaseAuth().initializeFirebase();
  }

  Future<void> checkNextScreen() async {
    String nextRoute = Routes.welcomeRoute;
    final User? user = DatabaseAuth().getCurrentUser();
    if (user != null) {
      final UserModel? userModel = await DatabaseUser().getUserByUid(user.uid);
      if (userModel == null) {
        nextRoute = Routes.welcomeRoute;
      } else if (userModel.kindOfUser == KindOfUser.ADMIN) {
        nextRoute = Routes.homeAdminRoute;
      } else if (userModel.kindOfUser == KindOfUser.SALON) {
        nextRoute = Routes.homeSalonRoute;
      } else if (userModel.kindOfUser == KindOfUser.BARBER) {
        nextRoute = Routes.homeBarberRoute;
      } else if (userModel.kindOfUser == KindOfUser.CUSTOMER) {
        nextRoute = Routes.homeCustomerRoute;
      }
    }
    Routes.goTo(nextRoute);
  }
}
