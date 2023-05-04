import 'package:barber_center/database/database_image.dart';
import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_barber.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBarberProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  final DatabaseService _dbService = DatabaseService();

  final DatabaseImage _dbImage = DatabaseImage();
  List<ServiceModel> services = [];

  late UserModel userModel;
  late BarberModel barberModel;
  bool loading = true;
  late String uid;

  ProfileBarberProvider() {
    uid = _dbAuth.getCurrentUser()!.uid;

    init();
  }

  Future<void> getServices() async {
    services = await _dbService.getServices();
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
    final XFile? imageFile = await _dbImage.selectImage(ImageSource.gallery, context);
    if (imageFile == null) {
      return;
    }
    final String image = await _dbImage.uploadImage(imageFile, 'images/user/');
    userModel.image = image;
    await _dbUser.updateUser(userModel);
    notifyListeners();
    showMessageSuccessful(' updated');
  }

  Future<void> init() async {
    await Future.wait([fetchMyProfile(), fetchBarberInformation(), getServices()]);
    debugPrint(services.length.toString());
    debugPrint('{ services : $services}');
    loading = false;
    notifyListeners();
  }
}
