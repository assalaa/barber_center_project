import 'database/db_auth.dart';
import 'services/constants.dart';
import 'services/routes.dart';
import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/services/constants.dart';
import 'package:barber_center/services/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String errorMessage = "Something went wrong";
    const String appTitle = "Barber Center";

    return FutureBuilder(
        future: DBAuth.initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(errorMessage);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              theme: ThemeData(primarySwatch: Colors.blue),
              onGenerateRoute: Routes.generateRoute,
              debugShowCheckedModeBanner: false,
              initialRoute: signupRoute,
              title: appTitle,
            );
          }
          return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange));
        });
    /*MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //home: const WelcomeScreen(),
    );*/
  }
}
