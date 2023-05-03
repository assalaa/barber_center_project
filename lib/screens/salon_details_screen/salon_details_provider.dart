import 'package:barber_center/database/db_barber.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/foundation.dart';

class SalonDetailsProvider with ChangeNotifier {
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  final DatabaseSalon _databaseSalon = DatabaseSalon();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  late UserModel salon;
  late SalonServiceModel salonService;
  late SalonInformationModel? salonInformation;
  late List<BarberModel> employees = [];
  BarberModel? selectedEmployee;

  bool loading = true;
  bool homeService = false;

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

    /// Remove services that has no employees to do it
    salonService.services.removeWhere((service) => !employees
        .any((element) => element.services.contains(service.serviceId)));

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
  }

  Future<void> _getEmployees(String uid) async {
    employees = await _dbBarber.getBarbersFromSalonId(uid);
  }

  void changeHomeService(bool value) {
    homeService = value;
    if (selectedEmployee?.homeService != true && homeService) {
      selectedEmployee = null;
    }
    notifyListeners();
  }

  void selectEmployee(BarberModel barberModel) {
    selectedEmployee = barberModel;

    notifyListeners();
  }

  void selectCategory(int i) {
    salonService.services[i].selected = !salonService.services[i].selected;

    if (salonService.services[i].selected) {
      checkEmployee(salonService.services[i].serviceId);
    }

    notifyListeners();
  }

  void checkEmployee(String serviceId) {
    if (selectedEmployee != null) {
      if (!selectedEmployee!.services.contains(serviceId)) {
        selectedEmployee = null;
      }
    }
  }

  bool hasItemSelected() {
    salonService.setPriceAndDuration();
    return salonService.services.any((element) => element.selected);
  }

  bool hasEmployeeSelected() {
    return selectedEmployee != null;
  }

  bool isEmployeeCapable(BarberModel barberModel) =>
      (barberModel.homeService && homeService == true ||
          homeService == false) &&
      salonService.services.every((element) =>
          (element.selected &&
              barberModel.services.contains(element.serviceId)) ||
          (!element.selected));

  bool canBook() {
    return salonInformation != null && employees.isNotEmpty;
  }
}
