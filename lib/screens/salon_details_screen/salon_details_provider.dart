import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/foundation.dart';

class SalonDetailsProvider with ChangeNotifier {
  final DatabaseUser _databaseUser = DatabaseUser();
  late UserModel userModel;
  bool loading = true;

  SalonDetailsProvider(String uid) {
    init(uid);
  }

  void init(String uid) async {
    await getSalon(uid);
    loading = false;
    notifyListeners();
  }

  Future<void> getSalon(String uid) async {
    userModel = (await _databaseUser.getUserByUid(uid))!;
  }
}
