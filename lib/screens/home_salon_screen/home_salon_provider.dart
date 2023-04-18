import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeSalonProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  bool loading = true;
  late bool isProfileCompleted;
  late User user;

  HomeSalonProvider() {
    init();
  }

  Future<void> init() async {
    user = _dbAuth.getCurrentUser()!;
    isProfileCompleted = await _dbSalon.isProfileCompleted(user.uid);
    loading = false;
    notifyListeners();
  }
}
