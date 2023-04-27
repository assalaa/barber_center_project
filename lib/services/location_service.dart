import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Placemark?> getPlacemarkFromLatLng(Position position) async {
    Placemark? place;

    await placemarkFromCoordinates(position.latitude, position.longitude,
            localeIdentifier: 'US')
        .then((placemarks) {
      place = placemarks[0];
    }).catchError((e) {
      debugPrint(e);
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
      // TODO(assala): Show a popup tells users to 'enable the location services of DEVICE'
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // TODO(assala): user doesn't give their location on purpose. We can tell: 'we couldnt have your location'

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // TODO(assala): show a popup that tells click here to open location settings and allow the location for this APP

      await Geolocator.openLocationSettings();

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static double calculateDistance(
      Position startPosition, Position endPosition) {
    return Geolocator.distanceBetween(startPosition.latitude,
        startPosition.longitude, endPosition.latitude, endPosition.longitude);
  }
}
