import 'package:barber_center/database/db_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:barber_center/services/routes.dart';

class SignINScreenProvider with ChangeNotifier {
  final DBAuth _dbAuth = DBAuth();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visiblePassword = true;

  void obscurePass() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  Future<void> signIn(String kinkOfUser) async {
    if (formKey.currentState!.validate()) {
      await _dbAuth.signInWithEmailAndPassword(emailController.text, passwordController.text)?.then((value) {
        if (value != null) {
          Routes.goTo(Routes.homeRoute);
        }
      });
    }
  }
}
