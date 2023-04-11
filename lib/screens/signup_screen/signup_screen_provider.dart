import 'package:flutter/material.dart';

class SignUPScreenProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool obserText = true;

  obscurePass() {
    obserText = !obserText;
    notifyListeners();
  }
}
