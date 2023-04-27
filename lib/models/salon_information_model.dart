import 'package:barber_center/models/location_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalonInformationModel {
  final String salonId;
  String salonName;
  String address;
  String phone;
  DateTime openTime;
  DateTime closeTime;
  bool isAvailable;
  LocationModel? location;

  SalonInformationModel({
    required this.salonId,
    required this.salonName,
    required this.address,
    required this.phone,
    required this.openTime,
    required this.closeTime,
    required this.isAvailable,
    this.location,
  });

  factory SalonInformationModel.fromJson(Map json) {
    return SalonInformationModel(
      salonId: json['salonId'],
      salonName: json['salonName'],
      address: json['address'],
      phone: json['phone'] ?? '',
      openTime: json['openTime'].toDate(),
      closeTime: json['closeTime'].toDate(),
      isAvailable: json['isAvailable'] ?? true,
      location: json.containsKey('location')
          ? LocationModel.fromJson(json['location'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'salonId': salonId,
        'salonName': salonName,
        'address': address,
        'phone': phone,
        'openTime': Timestamp.fromDate(openTime.toUtc()),
        'closeTime': Timestamp.fromDate(closeTime.toUtc()),
        'isAvailable': isAvailable,
        'location': location?.toJson(),
      };

  static SalonInformationModel emptySalon(String salonId) =>
      SalonInformationModel(
        salonId: salonId,
        salonName: '',
        address: '',
        phone: '',
        openTime: DateTime(2023).copyWith(hour: 9),
        closeTime: DateTime(2023).copyWith(hour: 17),
        isAvailable: true,
      );
}
