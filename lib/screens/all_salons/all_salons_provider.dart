import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/foundation.dart';

class AllSalonProvider with ChangeNotifier {
  final DatabaseUser _databaseUser = DatabaseUser();
  List<UserModel> users = [];
  bool loading = true;

  AllSalonProvider() {
    getAllSalon();
  }
  Future<void> getAllSalon() async {
    users = await _databaseUser.getUser();
  }
}
