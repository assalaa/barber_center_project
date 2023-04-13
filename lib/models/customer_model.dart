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
    required this.email,
    required this.phone,
    this.image,
  });

  factory CustomerModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
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
      'uid': uid,
      'name': name,
      'image': image,
      'email': email,
      'phone': phone,
    };
  }

  static CustomerModel emptyCustomer() {
    return CustomerModel(uid: '-1', name: '', email: '', phone: '');
  }

  bool get isEmpty => uid == '-1';
}
