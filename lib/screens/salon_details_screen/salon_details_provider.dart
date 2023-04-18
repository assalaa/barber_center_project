import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:flutter/foundation.dart';

class SalonDetailsProvider with ChangeNotifier {
  final DatabaseUser _databaseUser = DatabaseUser();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  late UserModel userModel;
  late SalonServiceModel salonServiceModel;
  bool loading = true;

  SalonDetailsProvider(String uid) {
    init(uid);
  }

  Future<void> init(String uid) async {
    await getSalon(uid);
    await getSalonServices();
    loading = false;
    notifyListeners();
  }

  Future<void> getSalon(String uid) async {
    userModel = (await _databaseUser.getUserByUid(uid))!;
  }

  Future<void> getSalonServices() async {
    salonServiceModel =
        await _dbSalonService.getServicesByUserId(userModel.uid);
  }
}
