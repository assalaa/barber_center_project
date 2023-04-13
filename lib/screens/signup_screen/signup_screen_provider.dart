import 'package:barber_center/database/db_auth.dart';
import 'package:flutter/material.dart';


class SignUPScreenProvider with ChangeNotifier {
  final DBAuth _dbAuth = DBAuth();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool obserText = true;

  void obscurePass() {
    obserText = !obserText;
    notifyListeners();
  }

  Future<void> saveUser(BuildContext context) async {
    formKey.currentState?.save();
    if (formKey.currentState!.validate()) {
      await _dbAuth
          .registerWithEmailAndPassword(
              emailController.text, passwordController.text)
          ?.then((user) async {
        if (user != null) {
          // final CustomerModel customerModel = CustomerModel(
          //   uid: user.uid,
          //   name: usernameController.text,
          //   email: emailController.text,
          //   phone: phoneController.text,
          // );
          // await DBProfile().createFirestoreUser(customerModel).then((value) {
          //   Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (context) => const HomeScreen()));
          // });
        }
      });
    }
  }
}
