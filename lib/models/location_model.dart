import 'package:barber_center/services/location_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class LocationModel {
  GeoPoint geoPoint;
  Placemark? placemark;

  LocationModel({
    required this.geoPoint,
    this.placemark,
  });

  factory LocationModel.fromJson(Map json) => LocationModel(
        geoPoint: json['geoPoint'],
        placemark: json.containsKey('placemark')
            ? toPlacemark(json['placemark'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'geoPoint': geoPoint,
        'placemark': placemark?.toJson(),
      };

  String? get getAddress => LocationService.placemarkToAddress(placemark);

  static Placemark toPlacemark(Map json) => Placemark(
        name: json['name'],
        street: json['street'],
        isoCountryCode: json['isoCountryCode'],
        country: json['country'],
        postalCode: json['postalCode'],
        administrativeArea: json['administrativeArea'],
        subAdministrativeArea: json['subAdministrativeArea'],
        locality: json['locality'],
        subLocality: json['subLocality'],
        thoroughfare: json['thoroughfare'],
        subThoroughfare: json['subThoroughfare'],
      );
}
