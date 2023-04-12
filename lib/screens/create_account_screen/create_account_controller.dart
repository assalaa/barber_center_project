import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/customer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountController with ChangeNotifier {
  final DBAuth _dbAuth = DBAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  bool loading = false;
  bool visiblePassword = true;

  void obscurePass() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  Future<void> saveUser(String kindOfUser) async {
    if (formKey.currentState!.validate()) {
      final User? user = await _dbAuth.registerWithEmailAndPassword(email.text, password.text);
      if (user == null) {
        return;
      }
      final UserModel userModel = UserModel(
        email: email.text,
        name: name.text,
        phone: phone.text,
        uid: user.uid,
        kindOfUser: kindOfUser,
      );
      saveUserInDatabase(userModel);
    }
  }

  void saveUserInDatabase(UserModel userModel) {
    _dbUser.addUser(userModel);
    loading = false;
    notifyListeners();
  }
}
