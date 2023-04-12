import 'package:barber_center/database/db_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../services/routes.dart';

class SignINScreenProvider with ChangeNotifier {
  final DBAuth _dbAuth = DBAuth();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obserText = true;

  obscurePass() {
    obserText = !obserText;
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      await _dbAuth.signInWithEmailAndPassword(emailController.text, passwordController.text)?.then((value) {
        if (value != null) {
        Routes.goTo(Routes.homeRoute);
        }
      });
    }
  }
}
