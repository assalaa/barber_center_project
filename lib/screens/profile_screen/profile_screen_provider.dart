import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_employees.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreenProvider with ChangeNotifier {
  late final DBAuth _dbAuth = DBAuth();
  late final DatabaseUser _databaseUser = DatabaseUser();
  late final DatabaseEmployee _databaseEmployee = DatabaseEmployee();
  late final DatabaseService _databaseService = DatabaseService();
  UserModel? userModel;
  List<EmployeeModel>? employees;
  List<ServiceModel>? services;
  bool loading = false;

  ProfileScreenProvider() {
    fetchMyProfile();
    fetchEmployees();
    fetchServices();
  }

  void logout() {
    _dbAuth.logOut().then((value) => Routes.goTo(Routes.welcomeRoute));
  }

  Future<void> fetchMyProfile() async {
    loading = true;
    notifyListeners();
    final String? uid = _dbAuth.getCurrentUser()?.uid;
    userModel = uid != null ? await _databaseUser.getUserByUid(uid) : null;
    loading = false;
    notifyListeners();
  }

  Future<void> fetchEmployees() async {
    loading = true;
    notifyListeners();
    final String? uid = _dbAuth.getCurrentUser()?.uid;
    employees = uid != null ? await _databaseEmployee.getEmployees(uid) : null;
    loading = false;
    notifyListeners();
  }

  Future<void> fetchServices() async {
    loading = true;
    notifyListeners();
    final String? uid = _dbAuth.getCurrentUser()?.uid;
    if (uid != null) {
      final List<String>? serviceIds = await _fetchServiceIds(uid);
      debugPrint(serviceIds.toString());
      if (serviceIds != null) {
        services = await _databaseService.getMultipleServicesByIds(serviceIds);
      }
    }

    loading = false;
    notifyListeners();
  }

  Future<List<String>?>? _fetchServiceIds(String uid) async {
    final UserModel? userModel = await _databaseUser.getUserByUid(uid);

    return userModel?.services;
  }
}