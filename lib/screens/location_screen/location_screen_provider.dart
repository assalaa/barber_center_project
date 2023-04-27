import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/models/location_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController country = TextEditingController();
  final TextEditingController countryCode = TextEditingController();
  final TextEditingController administrativeArea = TextEditingController();
  final TextEditingController subAdministrativeArea = TextEditingController();
  final TextEditingController locality = TextEditingController();
  final TextEditingController subLocality = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController thoroughfare = TextEditingController();
  final TextEditingController subThoroughfare = TextEditingController();

  final DatabaseSalon _dbSalon = DatabaseSalon();

  SalonInformationModel salonInformationModel;
  LocationModel? locationModel;

  bool loading = true;
  bool loadingSave = false;

  bool showMap = true;

  LocationProvider({required this.salonInformationModel}) {
    _init();
  }

  Future<void> _init() async {
    locationModel = salonInformationModel.location;
    loading = false;
    notifyListeners();
  }

  void changeShowMap(bool show) {
    showMap = show;
    notifyListeners();
  }

  Future<void> save() async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      loadingSave = true;
      notifyListeners();

      Future.delayed(const Duration(seconds: 1), () {
        loadingSave = false;
        notifyListeners();
        Routes.back();
        Routes.back();
      });
    }
  }
}
