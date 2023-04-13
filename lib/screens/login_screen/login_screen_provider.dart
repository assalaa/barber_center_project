import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/main.dart';
import 'package:barber_center/models/customer_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginController with ChangeNotifier {
  final DBAuth _dbAuth = DBAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visiblePassword = true;
  bool loading = false;

  void obscurePass() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  Future<void> login(KindOfUser kinkOfUser) async {
    if (formKey.currentState!.validate() && !loading) {
      loading = true;
      notifyListeners();
      final User? user = await _dbAuth.signInWithEmailAndPassword(
        email.text,
        password.text,
      );
      if (user == null) {
        loading = false;
        notifyListeners();
        return;
      }
      final UserModel? userModel = await _dbUser.getUserByUid(user.uid);
      if (userModel == null) {
        return;
      }
      goToPageByKindOfUser(user, kinkOfUser);

      loading = false;
      notifyListeners();
    }
  }

  void goToPageByKindOfUser(User user, KindOfUser kinkOfUser) {
    if (kinkOfUser == KindOfUser.SALON) {
      Routes.goTo(Routes.homeSalonRoute);
    } else if (kinkOfUser == KindOfUser.CUSTOMER) {
      Routes.goTo(Routes.homeCustomerRoute);
    } else if (kinkOfUser == KindOfUser.BARBER) {
      Routes.goTo(Routes.homeBarberRoute);
    }
  }
}
