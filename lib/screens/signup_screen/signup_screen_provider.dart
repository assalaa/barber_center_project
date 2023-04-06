import 'package:flutter/cupertino.dart';

class SignUPScreenProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
}
