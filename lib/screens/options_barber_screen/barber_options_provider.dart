import 'package:barber_center/database/database_image.dart';
import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_barber.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/popup.dart';
import 'package:flutter/material.dart';

class BarberOptionsProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  final DatabaseUser _dbUser = DatabaseUser();
  late BarberModel barberModel;
  final DatabaseImage _dbImage = DatabaseImage();
  late UserModel userModel;

  final TextEditingController tcAddress = TextEditingController();
  final TextEditingController tcName = TextEditingController();
  final TextEditingController tcPhone = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool loading = true;

  BarberOptionsProvider() {
    init();
  }

  Future<void> init() async {
    final String userId = _dbAuth.getCurrentUser()!.uid;
    barberModel = (await _dbBarber.getBarber(userId)) ?? BarberModel.emptyBarberInfo(userId);
    tcName.text = barberModel.barberName;
    tcPhone.text = barberModel.phone;

    loading = false;
    notifyListeners();
  }

  Future<void> changeAvailability(bool? value) async {
    if (value != null) {
      if (value == false) {
        if (await Popup.closeMyBookings()) {
          barberModel.homeService = value;
        }
      } else {
        barberModel.homeService = value;
      }
      notifyListeners();
    }
  }

  bool check() {
    if (!formKey.currentState!.validate()) {
      showMessageError('Please fill all the fields');
    } else {
      return true;
    }
    return false;
  }

  Future<void> save() async {
    if (check()) {
      barberModel.barberName = tcName.text;
      barberModel.phone = tcPhone.text;
      await _dbBarber.updateBarberInformation(barberModel);
      showMessageSuccessful('Saved');
      Routes.goTo(Routes.splashRoute);
    }
  }
}
