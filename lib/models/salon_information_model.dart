import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
>>>>>>> 27d418784bccd97c002e29704ad0efc7366fc597

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
<<<<<<< HEAD
      openTime: json['openTime'].toDate().toLocal(),
      closeTime: json['closeTime'].toDate().toLocal(),
      employees: List<String>.from(json['employees']),
=======
      openTime: json['openTime'].toDate(),
      closeTime: json['closeTime'].toDate(),
      employees: List<String>.from(json['employees'].map((x) => x)),
>>>>>>> 27d418784bccd97c002e29704ad0efc7366fc597
    );
  }

  Map<String, dynamic> toJson() => {
        'salonId': salonId,
        'address': address,
        'chairs': chairs,
        'openTime': Timestamp.fromDate(openTime.toUtc()),
        'closeTime': Timestamp.fromDate(closeTime.toUtc()),
<<<<<<< HEAD
        'employees': List<dynamic>.from(employees.map((e) => e)),
=======
        'employees': List<dynamic>.from(employees.map((x) => x)),
>>>>>>> 27d418784bccd97c002e29704ad0efc7366fc597
      };
}
