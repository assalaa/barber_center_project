import 'package:cloud_firestore/cloud_firestore.dart';

class CostumerModel {
  String? uid;
  String? name;
  String? image;
  String? email;
  String? phone;

  CostumerModel({
    required uid,
    required name,
    required image,
    required email,
    required phone,
  });

  factory CostumerModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CostumerModel(
      uid: data?['uid'],
      name: data?['name'],
      image: data?['image'],
      email: data?['email'],
      phone: data?['phone'],
    );
  }

  factory CostumerModel.fromJson(Map<String, dynamic> json) {
    return CostumerModel(
      uid: json['uid'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (image != null) "image": image,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
    };
  }
}
