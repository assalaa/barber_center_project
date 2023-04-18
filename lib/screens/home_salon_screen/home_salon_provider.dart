import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeSalonProvider with ChangeNotifier {
  late User user;

  bool loading = true;

  HomeSalonProvider() {
    init();
  }

  Future<void> init() async {
    loading = false;
    notifyListeners();
  }
}
