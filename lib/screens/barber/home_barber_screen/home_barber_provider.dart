import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/cupertino.dart';

class HomeBarberProvider with ChangeNotifier {
  final DatabaseUser _dbUsers = DatabaseUser();
  final DatabaseAuth _dbAuth = DatabaseAuth();
  bool loading = true;
  late Locale myLocale;
  late UserModel userModel;

  HomeBarberProvider() {
    init();
  }
  Future<void> init() async {
    await Future.wait([getCurrentBarber()]);
    myLocale = Localizations.localeOf(Routes.navigator.currentContext!);
    loading = false;
    notifyListeners();
  }

  Future<void> getCurrentBarber() async {
    final String uid = _dbAuth.getCurrentUser()!.uid;
    userModel = (await _dbUsers.getUserByUid(uid))!;
  }
}
