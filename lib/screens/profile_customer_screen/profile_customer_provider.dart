import 'package:barber_center/database/database_image.dart';
import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCustomerProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseImage _dbImage = DatabaseImage();

  late UserModel userModel;

  bool loading = true;

  ProfileCustomerProvider() {
    init();
  }

  void logout() {
    _dbAuth.logOut().then((value) => Routes.goTo(Routes.welcomeRoute));
  }

  Future<void> fetchMyProfile() async {
    final String uid = _dbAuth.getCurrentUser()!.uid;
    userModel = (await _dbUser.getUserByUid(uid))!;
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
    await fetchMyProfile();
    loading = false;
    notifyListeners();
  }
}