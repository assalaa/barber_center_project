import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon_information.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/foundation.dart';

class SalonDetailsProvider with ChangeNotifier {
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  final DBSalonInformation _dbSalonInformation = DBSalonInformation();
  late UserModel salon;
  late SalonServiceModel salonService;
  late SalonInformationModel salonInformation;

  bool loading = true;

  SalonDetailsProvider(String uid) {
    init(uid);
  }

  Future<void> init(String uid) async {
    await Future.wait([
      getSalon(uid),
      getSalonService(uid),
      getSalonInformation(uid),
    ]);
    loading = false;
    notifyListeners();
  }

  Future<void> getSalon(String uid) async {
    salon = (await _dbUser.getUserByUid(uid))!;
  }

  Future<void> getSalonService(String uid) async {
    salonService = await _dbSalonService.getServicesByUserId(uid);
  }

  Future<void> getSalonInformation(String uid) async {
    salonInformation = await _dbSalonInformation.getSalonInfoById(uid);
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
}
