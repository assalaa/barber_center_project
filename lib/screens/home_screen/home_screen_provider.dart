import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  late final DatabaseUser _databaseUser = DatabaseUser();
  late List<UserModel> users = [];
  bool loading = false;

  Future<List<UserModel>> fetchSalons() async {
    loading = true;
    notifyListeners();
    users = await _databaseUser.getUser();
    return users;
  }
}
