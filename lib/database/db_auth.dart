import 'package:barber_center/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DBAuth {
  late FirebaseAuth firebaseAuth;
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  DBAuth() {
    firebaseAuth = FirebaseAuth.instance;
  }

  bool get isUserLoggedIn => firebaseAuth.currentUser != null;

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> signup(BuildContext context, String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  Future<User?>? signInWithEmailAndPassword(String emailAddress, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(email: emailAddress, password: password);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user');
      }
      return null;
    }
  }

  Future<User?>? registerWithEmailAndPassword(String emailAddress, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(email: emailAddress, password: password);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for that email');
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: 'There was an error while registering. Try again later');
    }
    return null;
  }
}
