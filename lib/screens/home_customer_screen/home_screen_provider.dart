import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_barber.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/salon_employee_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  final DatabaseUser _dbUsers = DatabaseUser();
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  final DatabaseService _dbServices = DatabaseService();
  List<UserModel> salons = [];
  List<ServiceModel> services = [];
  List<SalonServiceModel> salonsServices = [];
  List<SalonInformationModel> salonsInformation = [];
  List<SalonEmployeeModel> salonEmployees = [];
  late UserModel userModel;

  late Locale myLocale;

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

  Future<void> getUser() async {
    final String uid = _dbAuth.getCurrentUser()!.uid;
    userModel = (await _dbUsers.getUserByUid(uid))!;
  }

  Future<void> init() async {
    await Future.wait([
      getSalons(),
      getServices(),
      getSalonsServices(),
      getSalonsEmployees(),
      getSalonsInformation(),
      getUser(),
    ]);
    //remove salon where there is no services with same salonId
    salons.removeWhere((element) =>
        salonsServices.indexWhere((e) => e.salonId == element.uid) == -1);
    //remove salon where there is no salonsInformation with same salonId
    salons.removeWhere((element) =>
        salonsInformation.indexWhere((e) => e.salonId == element.uid) == -1);
    //remove salon where there is no employees with same salonId
    salons.removeWhere((element) =>
        salonEmployees.indexWhere((e) => e.salonId == element.uid) == -1);
    myLocale = Localizations.localeOf(Routes.navigator.currentContext!);

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
    salonEmployees = await _dbBarber.getBarbers();
  }
}
