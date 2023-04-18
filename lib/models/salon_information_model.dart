import 'package:flutter/material.dart';

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
    debugPrint('SalonInformationModel.fromJson: $json');
    return SalonInformationModel(
      salonId: json['salonId'],
      address: json['address'],
      chairs: json['chairs'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      employees: json['employees'],
    );
  }

  Map<String, dynamic> toJson() => {
        'salonId': salonId,
        'address': address,
        'chairs': chairs,
        'openTime': openTime,
        'closeTime': closeTime,
        'employees': employees,
      };
}
