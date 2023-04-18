import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeSalonProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  bool loading = true;
  late bool isProfileCompleted;
  late SalonServiceModel salonServiceModel;
  late User user;

  HomeSalonProvider() {
    init();
  }

  Future<void> init() async {
    user = _dbAuth.getCurrentUser()!;
    await Future.wait([
      setIsProfileCompleted(),
      setIsServicesCompleted(),
    ]);
    loading = false;
    notifyListeners();
  }

  Future<void> setIsProfileCompleted() async {
    isProfileCompleted = await _dbSalon.isProfileCompleted(user.uid);
  }

  Future<void> setIsServicesCompleted() async {
    salonServiceModel = await _dbSalonService.getServicesByUserId(user.uid);
  }

  bool hasServices() {
    return salonServiceModel.services.isNotEmpty;
  }
}
