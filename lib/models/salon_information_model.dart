import 'package:cloud_firestore/cloud_firestore.dart';

class SalonInformationModel {
  final String salonId;
  int chairs;
  String address;
  DateTime openTime;
  DateTime closeTime;
  List<String> employees;

  SalonInformationModel({
    required this.salonId,
    required this.chairs,
    required this.openTime,
    required this.closeTime,
    required this.address,
    this.employees = const [],
  });

  factory SalonInformationModel.fromJson(Map json) {
    return SalonInformationModel(
      salonId: json['salonId'],
      address: json['address'],
      chairs: json['chairs'],
      openTime: json['openTime'].toDate(),
      closeTime: json['closeTime'].toDate(),
      employees: List<String>.from(json['employees'].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        'salonId': salonId,
        'address': address,
        'chairs': chairs,
        'openTime': Timestamp.fromDate(openTime.toUtc()),
        'closeTime': Timestamp.fromDate(closeTime.toUtc()),
        'employees': List<dynamic>.from(employees.map((x) => x)),
      };
}
