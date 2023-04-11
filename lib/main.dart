import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/services/constants.dart';
import 'package:barber_center/services/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DBAuth.initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              onGenerateRoute: Routes.generateRoute,
              initialRoute: homeRoute,
              title: 'Flutter Firebase Authentication Tutorial',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
            );
          }
          return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange));
        });
    /*MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //home: const WelcomeScreen(),
    );*/
  }
}
