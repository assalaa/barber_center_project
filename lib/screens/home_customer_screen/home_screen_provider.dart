import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  final DatabaseUser _dbUsers = DatabaseUser();
  final DatabaseService _dbServices = DatabaseService();
  late List<UserModel> salons = [];
  late List<ServiceModel> services = [];
  bool loading = true;

  HomeScreenProvider() {
    init();
  }

  Future<void> getSalons() async {
    salons = await _dbUsers.getSalons();
    for (final UserModel element in salons) {
      debugPrint(element.print());
    }
  }

  Future<void> getServices() async {
    services = await _dbServices.getServices();
  }

  Future<void> init() async {
    await Future.wait([
      getSalons(),
      getServices(),
    ]);
    loading = false;
    notifyListeners();
  }
}
