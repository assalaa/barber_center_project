import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String uid;
  String name;
  String? image;
  String email;
  String phone;

  CustomerModel({
    required this.uid,
    required this.name,
    this.image,
    required this.email,
    required this.phone,
  });

  factory CustomerModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CustomerModel(
      uid: data?['uid'],
      name: data?['name'],
      image: data?['image'],
      email: data?['email'],
      phone: data?['phone'],
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      uid: json['uid'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "name": name,
      "image": image,
      "email": email,
      "phone": phone,
    };
  }
}
