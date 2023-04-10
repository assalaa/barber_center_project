import 'package:barber_center/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../database/db_auth.dart';
import '../../models/salon_model.dart';
import '../../services/routes.dart';

class SignUPScreenProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RegExp regExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  bool obserText = true;

  bool loading = false;
  save() async {
    loading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      User? user = await createUser();
      if (user != null) {
        SalonModel userModel = await saveUserData(user);
        Routes.goTo(homeRoute, args: userModel);
      } else {
        return "process failed";
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<User?> createUser() async {
    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      return credential.user;
    } catch (error) {
      debugPrint('error $error');
    }
    return null;
  }

  Future<SalonModel> saveUserData(User user) async {
    SalonModel userModel = SalonModel(id: user.uid, salonEmail: emailController.text, salonPassword: passwordController.text, salonName: usernameController.text, salonAddress: addressController.text, salonContact: '', salonServices: []);
    await DBAuth().addNewUser(userModel);
    return userModel;
  }
}
