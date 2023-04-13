import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:flutter/material.dart';

class HomeAdminProvider extends ChangeNotifier {
  bool loading = true;
  final DatabaseService _dbServices = DatabaseService();
  List<ServiceModel> services = [];

  HomeAdminProvider() {
    init();
  }

  Future<void> init() async {
    getServices();
    loading = false;
    notifyListeners();
  }

  Future<void> getServices() async {
    services = await _dbServices.getServices();
  }
}
