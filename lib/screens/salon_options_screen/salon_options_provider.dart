import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/models/location_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/services/location_service.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SalonOptionsProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  late SalonInformationModel salonInformationModel;

  final TextEditingController tcAddress = TextEditingController();
  final TextEditingController tcName = TextEditingController();
  final TextEditingController tcPhone = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool loading = true;

  SalonOptionsProvider() {
    init();
  }

  Future<void> init() async {
    final String userId = _dbAuth.getCurrentUser()!.uid;

    salonInformationModel = (await _dbSalon.getSalonInformation(userId)) ??
        SalonInformationModel.emptySalon(userId);
    tcName.text = salonInformationModel.salonName;
    tcAddress.text = salonInformationModel.address;
    tcPhone.text = salonInformationModel.phone;

    loading = false;
    notifyListeners();
  }

  Future<void> updateLocation() async {
    final bool locationAllowed = (await Popup.askLocation()) ?? false;

    if (locationAllowed) {
      try {
        final Position currentPosition =
            await LocationService.getCurrentPosition();
        debugPrint('$currentPosition');

        final Placemark? placemark =
            await LocationService.getPlacemarkFromLatLng(
                currentPosition.latitude, currentPosition.longitude);
        debugPrint(placemark?.toJson().toString());

        salonInformationModel.location = LocationModel(
          geoPoint:
              GeoPoint(currentPosition.latitude, currentPosition.longitude),
          placemark: placemark,
        );
        notifyListeners();

        await _dbSalon.updateSalonInformation(salonInformationModel);
      } catch (e) {
        debugPrint('$e');
      }
    }
  }

  void updateOpenTime(String? value) {
    if (value != null) {
      final DateTime? newDate = value.toDateTime();

      if (newDate != null) {
        salonInformationModel.openTime = salonInformationModel.openTime
            .copyWith(hour: newDate.hour, minute: newDate.minute);
        notifyListeners();
      }
    }
  }

  void updateCloseTime(String? value) {
    if (value != null) {
      final DateTime? newDate = value.toDateTime();

      if (newDate != null) {
        salonInformationModel.closeTime = salonInformationModel.openTime
            .copyWith(hour: newDate.hour, minute: newDate.minute);
        notifyListeners();
      }
    }
  }

  Future<void> changeAvailability(bool? value) async {
    if (value != null) {
      if (value == false) {
        if (await Popup.closeMyBookings()) {
          salonInformationModel.isAvailable = value;
        }
      } else {
        salonInformationModel.isAvailable = value;
      }
      notifyListeners();
    }
  }

  bool check() {
    if (!formKey.currentState!.validate()) {
      showMessageError('Please fill all the fields');
    } else if (salonInformationModel.closeTime
        .isBefore(salonInformationModel.openTime)) {
      showMessageError('Closing time cannot be before than opening time');
    } else {
      return true;
    }
    return false;
  }

  Future<void> save() async {
    if (check()) {
      salonInformationModel.salonName = tcName.text;
      salonInformationModel.address = tcAddress.text;
      salonInformationModel.phone = tcPhone.text;

      await _dbSalon.updateSalonInformation(salonInformationModel);
      showMessageSuccessful('Saved');

      Routes.goTo(Routes.splashRoute);
    }
  }
}
