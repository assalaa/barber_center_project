import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  final DatabaseUser _databaseUser = DatabaseUser();
  final DatabaseService _databaseService = DatabaseService();
  late List<UserModel> users = [];
  late List<ServiceModel> services = [];

  bool loading = false;

  HomeScreenProvider() {
    fetchSalons();
    fetchServices();
  }

  Future<void> fetchSalons() async {
    loading = true;
    notifyListeners();
    users = await _databaseUser.getUser();
    loading = false;
    notifyListeners();
  }

  Future<void> fetchServices() async {
    loading = true;
    notifyListeners();
    services = await _databaseService.getServices();
    loading = false;
    notifyListeners();
  }
}
