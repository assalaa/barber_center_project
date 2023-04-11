import 'package:flutter/cupertino.dart';

class SignINScreenProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obserText = true;

  obscurePass() {
    obserText = !obserText;
    notifyListeners();
  }
}
