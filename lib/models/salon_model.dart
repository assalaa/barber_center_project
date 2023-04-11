import 'dart:convert';

class SalonModel {
  final String id;
  String? salonName;
  String? salonEmail;
  String? salonPassword;
  String? salonAddress;
  String? salonContact;
  List<String?> salonServices = [];

  SalonModel({
    required this.id,
    required this.salonName,
    required this.salonEmail,
    required this.salonPassword,
    required this.salonAddress,
    required this.salonContact,
    required this.salonServices,
  });
  Map<String, dynamic> toJson() {
    return {'id': id, 'salonName': salonName, 'salonEmail': salonEmail, 'salonPassword': salonPassword, 'salonAddress': salonAddress, 'salonContact': salonContact, 'salonServices': salonServices};
  }

  factory SalonModel.fromJson(Map map) {
    return SalonModel(
      id: map['id'],
      salonName: map['salonName'],
      salonEmail: map['salonEmail'],
      salonAddress: map['salonAddress'],
      salonContact: map['salonContact'],
      salonServices: map['salonServices'],
      salonPassword: '',
    );
  }
  String toSave() {
    return jsonEncode(toJson());
  }
}
