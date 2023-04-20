import 'package:cloud_firestore/cloud_firestore.dart';

class SalonInformationModel {
  final String salonId;
  String salonName;
  String address;
  String phone;
  DateTime openTime;
  DateTime closeTime;
  bool isAvailable;

  SalonInformationModel({
    required this.salonId,
    required this.salonName,
    required this.address,
    required this.phone,
    required this.openTime,
    required this.closeTime,
    required this.isAvailable,
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
