import 'package:barber_center/database/database_image.dart';
import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_employees.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSalonProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseEmployee _dbEmployee = DatabaseEmployee();
  final DatabaseService _dbService = DatabaseService();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  final DatabaseImage _dbImage = DatabaseImage();

  late UserModel userModel;
  late SalonInformationModel? salonInformationModel;
  late SalonServiceModel salonServiceModel;
  List<EmployeeModel> employees = [];
  List<ServiceModel> services = [];
  bool loading = true;
  late String uid;

  ProfileSalonProvider() {
    uid = _dbAuth.getCurrentUser()!.uid;

    init();
  }

  void logout() {
    _dbAuth.logOut().then((value) => Routes.goTo(Routes.welcomeRoute));
  }

  Future<void> fetchMyProfile() async {
    userModel = (await _dbUser.getUserByUid(uid))!;
  }

  Future<void> fetchSalonInformation() async {
    salonInformationModel = await _dbSalon.getSalonInformation(uid);
  }

  Future<void> fetchEmployees() async {
    employees = await _dbEmployee.getEmployees(uid);
  }

  Future<void> fetchServices() async {
    salonServiceModel = await _dbSalonService.getServicesByUserId(uid);

    services = await _dbService.getServices();
    //remove services where there is no in salonServiceModel
    services.removeWhere((element) =>
        !salonServiceModel.services.any((e) => e.serviceId == element.id));
  }

  Future<void> removeEmployee(EmployeeModel employeeModel) async {
    final bool? confirm = await Popup().show(
      title: 'Remove Employee',
      content:
          'Are you sure you want to remove the employee \'${employeeModel.name}\' from your salon?',
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(Routes.navigator.currentContext!, true),
          child: const Text('Remove'),
        ),
      ],
    );

    if (confirm == true) {
      loading = true;
      notifyListeners();

      await _dbEmployee.deleteEmployee(employeeModel.id);
      employees.removeWhere((element) => element.id == employeeModel.id);
      showMessageSuccessful('Employee successfully removed');

      loading = false;
      notifyListeners();
    }
  }

  Future<void> removeService(ServiceModel serviceModel) async {
    final bool? confirm = await Popup().show(
      title: 'Remove ${serviceModel.name}',
      content:
          'Are you sure you want to remove ${serviceModel.name} service from your salon?',
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(Routes.navigator.currentContext!, true),
          child: const Text('Remove'),
        ),
      ],
    );

    if (confirm == true) {
      loading = true;
      notifyListeners();
      salonServiceModel.services
          .removeWhere((element) => element.serviceId == serviceModel.id);
      services.removeWhere((element) => element.id == serviceModel.id);

      await _dbSalonService.updateService(salonServiceModel);
      showMessageSuccessful('Service successfully removed');

      loading = false;
      notifyListeners();
    }
  }

  Future<void> updatePhoto(BuildContext context) async {
    final XFile? imageFile =
        await _dbImage.selectImage(ImageSource.gallery, context);
    if (imageFile == null) {
      return;
    }
    final String image = await _dbImage.uploadImage(imageFile, 'images/user/');
    userModel.image = image;
    await _dbUser.updateUser(userModel);
    notifyListeners();
    showMessageSuccessful('Profile photo is successfully updated');
  }

  Future<void> init() async {
    await Future.wait([
      fetchMyProfile(),
      fetchSalonInformation(),
      fetchEmployees(),
      fetchServices(),
    ]);

    loading = false;
    notifyListeners();
  }
}
