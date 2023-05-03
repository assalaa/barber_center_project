import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/models/location_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/services/location_service.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/widgets/popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController country = TextEditingController();
  final TextEditingController administrativeArea = TextEditingController();
  final TextEditingController locality = TextEditingController();
  final TextEditingController subLocality = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController postalCode = TextEditingController();

  final DatabaseSalon _dbSalon = DatabaseSalon();

  SalonInformationModel salonInformationModel;

  LocationModel? locationModel;
  String address = '';

  bool loading = true;
  bool loadingSave = false;
  bool haveLocation = false;

  bool showMap = true;

  LocationProvider({required this.salonInformationModel}) {
    _init();
  }

  Future<void> _init() async {
    await getLocation();

    loading = false;
    notifyListeners();
  }

  Future<void> getLocation() async {
    try {
      loading = true;
      final Position position = await LocationService.getCurrentPosition();

      locationModel = LocationModel(
        geoPoint: GeoPoint(position.latitude, position.longitude),
      );
      await _getAddress();
      haveLocation = true;
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      if (e.runtimeType == LocationServiceDisabledException) {
        await Popup.locationServiceDisabled();
      } else if (e.runtimeType == PermissionDeniedException) {
        if (e.toString() == Strings.locationPermissionDeniedForever) {
          await Popup.openAppSettings();
        } else {
          await getLocation();
        }
      }
    }
  }

  Future<void> _getAddress() async {
    if (locationModel != null) {
      locationModel!.placemark = await LocationService.getPlacemarkFromLatLng(locationModel!.geoPoint.latitude, locationModel!.geoPoint.longitude);
      _fillTextFields();
    }
  }

  String? updatePlacemark(String txt) {
    final Placemark placemark = Placemark(
      country: country.text,
      administrativeArea: administrativeArea.text,
      locality: locality.text,
      subLocality: subLocality.text,
      street: street.text,
      postalCode: postalCode.text,
    );

    locationModel?.placemark = placemark;
    notifyListeners();
    return txt;
  }

  void _fillTextFields() {
    country.text = locationModel?.placemark?.country ?? '';
    administrativeArea.text = locationModel?.placemark?.administrativeArea ?? '';
    locality.text = locationModel?.placemark?.locality ?? '';
    subLocality.text = locationModel?.placemark?.subLocality ?? '';
    street.text = locationModel?.placemark?.street ?? '';

    postalCode.text = locationModel?.placemark?.postalCode ?? '';
  }

  void changeShowMap(bool show) {
    showMap = show;
    notifyListeners();
  }

  Future<void> save() async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate() && locationModel != null) {
      loadingSave = true;
      notifyListeners();

      salonInformationModel.address = locationModel!.getAddress ?? '';
      salonInformationModel.location = locationModel;

      await _dbSalon.updateSalonInformation(salonInformationModel);

      loadingSave = false;
      notifyListeners();
      Routes.back();
      Routes.back();
    }
  }
}
