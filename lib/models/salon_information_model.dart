import 'package:cloud_firestore/cloud_firestore.dart';

class SalonInformationModel {
  final String salonId;
  String salonName;
  int chairs;
  String address;
  DateTime openTime;
  DateTime closeTime;

  SalonInformationModel({
    required this.salonId,
    required this.chairs,
    required this.salonName,
    required this.openTime,
    required this.closeTime,
    required this.address,
  });

  factory SalonInformationModel.fromJson(Map json) {
    return SalonInformationModel(
      salonId: json['salonId'],
      address: json['address'],
      chairs: json['chairs'],
      salonName: json['salonName'],
      openTime: json['openTime'].toDate(),
      closeTime: json['closeTime'].toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'salonId': salonId,
        'address': address,
        'chairs': chairs,
        'salonName': salonName,
        'openTime': Timestamp.fromDate(openTime.toUtc()),
        'closeTime': Timestamp.fromDate(closeTime.toUtc()),
      };
}
