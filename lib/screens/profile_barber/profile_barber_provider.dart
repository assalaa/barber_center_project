import 'package:barber_center/database/database_image.dart';
import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_barber.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBarberProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  final DatabaseService _dbService = DatabaseService();
  final DatabaseSalon _dbSalon = DatabaseSalon();

  final DatabaseImage _dbImage = DatabaseImage();
  List<ServiceModel> services = [];
  late ServiceModel service;
  late ServiceModel serviceModel;

  late UserModel userModel;
  late BarberModel barberModel;
  SalonInformationModel? salonModel;
  bool loading = true;
  late String uid;
  late String skill;

  int selectedSkill = -1;

  bool get isSkillSelected => selectedSkill != -1;

  ProfileBarberProvider() {
    uid = _dbAuth.getCurrentUser()!.uid;

    _init();
  }
  Future<void> getSalonInfo() async {
    if (barberModel.salonId.isNotEmpty) {
      salonModel = await _dbSalon.getSalonInformation(barberModel.salonId);
    }
  }

  Future<void> getServices() async {
    services = await _dbService.getServices();
    //remove services where there is no in salonServiceModel
    services.removeWhere(
        (element) => !barberModel.services.any((e) => e == element.id));
  }

  Future<void> removeService(ServiceModel serviceModel) async {
    if (await Popup.removeService(serviceModel.name)) {
      loading = true;
      notifyListeners();
      if (barberModel.services.contains(serviceModel.id)) {
        barberModel.services.remove(serviceModel.id);
        await _dbBarber.updateBarber(barberModel);

        services.removeWhere((element) => element.id == serviceModel.id);
      }

      loading = false;
      notifyListeners();
    }
  }

  void logout() {
    _dbAuth.logOut().then((value) => Routes.goTo(Routes.welcomeRoute));
  }

  Future<void> fetchMyProfile() async {
    userModel = (await _dbUser.getUserByUid(uid))!;
  }

  Future<void> fetchBarberInformation() async {
    barberModel = (await _dbBarber.getBarber(uid))!;
  }

  Future<void> updatePhoto(BuildContext context) async {
    final XFile? imageFile =
        await _dbImage.selectImage(ImageSource.gallery, context);
    if (imageFile == null) {
      return;
    }
    final String image = await _dbImage.uploadImage(imageFile, 'images/user/');
    barberModel.image = image;
    await _dbBarber.updateBarber(barberModel);
    notifyListeners();
    showMessageSuccessful(' updated');
  }

  void chooseSkill(int index) {
    selectedSkill = index;
    notifyListeners();
  }

  Future<void> _init() async {
    await Future.wait([
      fetchMyProfile(),
      fetchBarberInformation(),
    ]);
    await getServices();
    await getSalonInfo();

    debugPrint(services.length.toString());
    debugPrint('{ services : $services}');
    loading = false;
    notifyListeners();
  }
}
