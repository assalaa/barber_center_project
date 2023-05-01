import 'package:barber_center/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Placemark?> getPlacemarkFromLatLng(
      double latitude, double longitude) async {
    Placemark? place;

    await placemarkFromCoordinates(latitude, longitude, localeIdentifier: 'US')
        .then((placemarks) {
      place = placemarks[0];
    }).catchError((e) {
      debugPrint(e.toString());
    });
    return place;
  }

  static String? placemarkToAddress(Placemark? place) {
    if (place == null) {
      return null;
    }
    return '${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.locality}, ${place.country}';
  }

  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(const LocationServiceDisabledException());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            const PermissionDeniedException(Strings.locationPermissionDenied));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(const PermissionDeniedException(
          Strings.locationPermissionDeniedForever));
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  static double calculateDistance(
      Position startPosition, Position endPosition) {
    return Geolocator.distanceBetween(startPosition.latitude,
        startPosition.longitude, endPosition.latitude, endPosition.longitude);
  }
}
