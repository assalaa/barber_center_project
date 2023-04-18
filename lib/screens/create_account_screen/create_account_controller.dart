import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/main.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountController with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController city = TextEditingController();
  bool loading = false;
  bool visiblePassword = true;

  void obscurePass() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  Future<void> saveUser(KindOfUser kindOfUser) async {
    if (formKey.currentState!.validate() && !loading) {
      loading = true;
      notifyListeners();
      final User? user = await _dbAuth.registerWithEmailAndPassword(email.text, password.text);
      if (user == null) {
        loading = false;
        notifyListeners();
        return;
      }
      final UserModel userModel = UserModel(
        email: email.text,
        createAt: DateTime.now(),
        name: name.text,
        city: city.text,
        uid: user.uid,
        kindOfUser: kindOfUser,
      );
      saveUserInDatabase(userModel);
      checkPageToGo(kindOfUser);
    }
  }

  void saveUserInDatabase(UserModel userModel) {
    _dbUser.addUser(userModel);
  }

  void checkPageToGo(KindOfUser kindOfUser) {
    if (kindOfUser == KindOfUser.CUSTOMER) {
      Routes.goTo(Routes.homeCustomerRoute);
    } else if (kindOfUser == KindOfUser.BARBER) {
      Routes.goTo(Routes.homeBarberRoute);
    } else if (kindOfUser == KindOfUser.SALON) {
      Routes.goTo(Routes.homeSalonRoute);
    }
  }
}
