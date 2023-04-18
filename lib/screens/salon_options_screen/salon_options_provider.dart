import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/material.dart';

class SalonOptionsProvider with ChangeNotifier {
  final DatabaseSalon _dbSalonInformation = DatabaseSalon();
  final DatabaseAuth _dbAuth = DatabaseAuth();
  late SalonInformationModel salonInformationModel;
  final TextEditingController tcAddress = TextEditingController();
  TextEditingController tcName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  late String userId;

  SalonOptionsProvider() {
    final DateTime now = DateTime(DateTime.now().year);
    userId = _dbAuth.getCurrentUser()!.uid;

    salonInformationModel = SalonInformationModel(
        salonId: userId,
        address: '',
        salonName: '',
        chairs: 1,
        openTime: DateTime(now.year).copyWith(hour: 9),
        closeTime: DateTime(now.year).copyWith(hour: 17));
  }

  void updateChairs(String? value) {
    if (value != null) {
      salonInformationModel.chairs = int.parse(value);
      notifyListeners();
    }
  }

  void updateOpenTime(String? value) {
    if (value != null) {
      final DateTime? newDate = value.toDateTime();

      if (newDate != null) {
        salonInformationModel.openTime =
            salonInformationModel.openTime.copyWith(hour: newDate.hour, minute: newDate.minute);
        notifyListeners();
      }
    }
  }

  void updateCloseTime(String? value) {
    if (value != null) {
      final DateTime? newDate = value.toDateTime();

      if (newDate != null) {
        salonInformationModel.closeTime =
            salonInformationModel.openTime.copyWith(hour: newDate.hour, minute: newDate.minute);
        notifyListeners();
      }
    }
  }

  bool check() {
    if (!formKey.currentState!.validate()) {
      showMessageError('Please fill all the fields');
    } else if (salonInformationModel.closeTime.isBefore(salonInformationModel.openTime)) {
      showMessageError('Closing time cannot be before than opening time');
    } else {
      return true;
    }
    return false;
  }

  Future<void> save() async {
    if (check()) {
      salonInformationModel.address = tcAddress.text;
      salonInformationModel.salonName = tcName.text;
      await _dbSalonInformation.createSalonInfo(salonInformationModel);
      showMessageSuccessful('Saved');

      Routes.goTo(Routes.splashRoute);
    }
  }
}
