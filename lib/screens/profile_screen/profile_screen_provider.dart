import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_employees.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreenProvider with ChangeNotifier {
  final DBAuth _dbAuth = DBAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseEmployee _dbEmployee = DatabaseEmployee();
  final DatabaseService _dbService = DatabaseService();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();

  late UserModel userModel;
  List<EmployeeModel> employees = [];
  List<ServiceModel> services = [];
  bool loading = true;

  ProfileScreenProvider() {
    fetchMyProfile();
    fetchEmployees();
    fetchServices();
    loading = false;
    notifyListeners();
  }

  void logout() {
    _dbAuth.logOut().then((value) => Routes.goTo(Routes.welcomeRoute));
  }

  Future<void> fetchMyProfile() async {
    final String uid = _dbAuth.getCurrentUser()!.uid;
    userModel = (await _dbUser.getUserByUid(uid))!;
  }

  Future<void> fetchEmployees() async {
    employees = await _dbEmployee.getEmployees(userModel.uid);
  }

  Future<void> fetchServices() async {
    final SalonServiceModel salonServiceModel = await _dbSalonService.getServicesByUserId(userModel.uid);

    services = await _dbService.getServices();
    //remove services where there is no in salonServiceModel
    services.removeWhere((element) => !salonServiceModel.services.any((e) => e.serviceId == element.id));
  }
}
