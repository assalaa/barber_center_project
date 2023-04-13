import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreenProvider with ChangeNotifier {
  late final DBAuth _dbAuth = DBAuth();
  late final DatabaseUser _databaseUser = DatabaseUser();
  UserModel? userModel;
  bool loading = false;

  ProfileScreenProvider() {
    fetchMyProfile();
  }

  void logout() {
    _dbAuth.logOut().then((value) => Routes.goTo(Routes.welcomeRoute));
  }

  Future<void> fetchMyProfile() async {
    loading = true;
    notifyListeners();
    final String? uid = _dbAuth.getCurrentUser()?.uid;
    userModel = uid != null ? await _databaseUser.getUserByUid(uid) : null;
    loading = false;
    notifyListeners();
  }
}
