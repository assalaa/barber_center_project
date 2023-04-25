import 'package:barber_center/database/db_employees.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/salon_employee_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  final DatabaseUser _dbUsers = DatabaseUser();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  final DatabaseEmployee _dbEmployee = DatabaseEmployee();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  final DatabaseService _dbServices = DatabaseService();
  List<UserModel> salons = [];
  List<ServiceModel> services = [];
  List<SalonServiceModel> salonsServices = [];
  List<SalonInformationModel> salonsInformation = [];
  List<SalonEmployeeModel> salonEmployees = [];
  bool loading = true;

  HomeScreenProvider() {
    init();
  }

  Future<void> getSalons() async {
    salons = await _dbUsers.getSalons();
  }

  Future<void> getServices() async {
    services = await _dbServices.getServices();
  }

  Future<void> init() async {
    await Future.wait([
      getSalons(),
      getServices(),
      getSalonsServices(),
      getSalonsEmployees(),
      getSalonsInformation(),
    ]);
    //remove salon where there is no services with same salonId
    salons.removeWhere((element) => salonsServices.indexWhere((e) => e.salonId == element.uid) == -1);
    //remove salon where there is no salonsInformation with same salonId
    salons.removeWhere((element) => salonsInformation.indexWhere((e) => e.salonId == element.uid) == -1);
    //remove salon where there is no employees with same salonId
    salons.removeWhere((element) => salonEmployees.indexWhere((e) => e.salonId == element.uid) == -1);

    loading = false;
    notifyListeners();
  }

  Future<void> getSalonsServices() async {
    salonsServices = await _dbSalonService.getAllSalonServices();
  }

  Future<void> getSalonsInformation() async {
    salonsInformation = await _dbSalon.getSalonsInformation();
  }

  Future<void> getSalonsEmployees() async {
    salonEmployees = await _dbEmployee.getAllEmployees();
  }
}
