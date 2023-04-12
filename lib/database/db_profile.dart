import 'package:cloud_firestore/cloud_firestore.dart';

class DBProfile {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static const customersPath = "customers";

  static Future<dynamic> createFirestoreUser() async {}
}
