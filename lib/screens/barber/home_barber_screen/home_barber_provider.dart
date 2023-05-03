import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_barber.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HomeBarberProvider with ChangeNotifier {
  final DatabaseUser _dbUsers = DatabaseUser();
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  bool loading = true;
  late Locale myLocale;
  late UserModel userModel;
  late bool isProfileCompleted;
  late User user;

  HomeBarberProvider() {
    init();
  }
  Future<void> init() async {
    user = _dbAuth.getCurrentUser()!;
    await Future.wait([getCurrentBarber(), setIsProfileCompleted()]);
    myLocale = Localizations.localeOf(Routes.navigator.currentContext!);
    loading = false;
    notifyListeners();
  }

  Future<void> setIsProfileCompleted() async {
    isProfileCompleted = await _dbBarber.isProfileCompleted(user.uid);
  }

  Future<void> getCurrentBarber() async {
    final String uid = _dbAuth.getCurrentUser()!.uid;
    userModel = (await _dbUsers.getUserByUid(uid))!;
  }
}
