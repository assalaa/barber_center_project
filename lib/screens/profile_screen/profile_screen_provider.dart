import 'package:barber_center/database/database_image.dart';
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
import 'package:image_picker/image_picker.dart';

class ProfileScreenProvider with ChangeNotifier {
  final DBAuth _dbAuth = DBAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseEmployee _dbEmployee = DatabaseEmployee();
  final DatabaseService _dbService = DatabaseService();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  final DatabaseImage _dbImage = DatabaseImage();

  late UserModel userModel;
  List<EmployeeModel> employees = [];
  List<ServiceModel> services = [];
  bool loading = true;

  ProfileScreenProvider() {
    init();
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
    //services.removeWhere((element) => !salonServiceModel.services.any((e) => e.serviceId == element.id));
  }

  Future<void> updatePhoto(BuildContext context) async {
    final XFile? imageFile = await _dbImage.selectImage(ImageSource.gallery, context);
    if (imageFile == null) {
      return;
    }
    final String image = await _dbImage.uploadImage(imageFile, 'images/user/');
    userModel.image = image;
    await _dbUser.updateUser(userModel);
    Routes.goTo(Routes.splashRoute);
  }

  Future<void> init() async {
    await fetchMyProfile();
    await fetchEmployees();
    await fetchServices();
    loading = false;
    notifyListeners();
  }
}
