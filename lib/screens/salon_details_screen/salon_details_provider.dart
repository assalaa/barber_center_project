import 'package:barber_center/database/db_employees.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/foundation.dart';

class SalonDetailsProvider with ChangeNotifier {
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  final DatabaseSalon _databaseSalon = DatabaseSalon();
  final DatabaseEmployee _dbEmployee = DatabaseEmployee();
  late UserModel salon;
  late SalonServiceModel salonService;
  late SalonInformationModel? salonInformation;
  late List<EmployeeModel> employees = [];
  late EmployeeModel selectedEmployee;

  bool loading = true;

  SalonDetailsProvider(String uid) {
    init(uid);
  }

  Future<void> init(String uid) async {
    await Future.wait([
      _getSalon(uid),
      _getSalonService(uid),
      _getSalonInformation(uid),
      _getEmployees(uid),
    ]);
    selectEmployee(employees.first);

    loading = false;
    notifyListeners();
  }

  Future<void> _getSalon(String uid) async {
    salon = (await _dbUser.getUserByUid(uid))!;
  }

  Future<void> _getSalonService(String uid) async {
    salonService = await _dbSalonService.getServicesByUserId(uid);
  }

  Future<void> _getSalonInformation(String uid) async {
    salonInformation = await _databaseSalon.getSalonInformation(uid);
    notifyListeners();
  }

  Future<void> _getEmployees(String uid) async {
    employees = await _dbEmployee.getEmployees(uid);
    notifyListeners();
  }

  void selectEmployee(EmployeeModel employeeModel) {
    selectedEmployee = employeeModel;
    notifyListeners();
  }

  void selectCategory(int i) {
    salonService.services[i].selected = !salonService.services[i].selected;
    notifyListeners();
  }

  bool hasItemSelected() {
    salonService.setPriceAndDuration();
    return salonService.services.any((element) => element.selected);
  }

  bool canBook() {
    return salonInformation != null && employees.isNotEmpty;
  }
}
