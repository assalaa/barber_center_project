import 'package:barber_center/database/db_auth.dart';
import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class SignUPScreenProvider with ChangeNotifier {
  final DBAuth _dbAuth = DBAuth();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool obserText = true;

  obscurePass() {
    obserText = !obserText;
    notifyListeners();
  }

  Future<void> saveUser(BuildContext context) async {
    formKey.currentState?.save();
    if (formKey.currentState!.validate()) {
      await _dbAuth
          .registerWithEmailAndPassword(
              emailController.text, passwordController.text)
          ?.then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    }
  }
}
