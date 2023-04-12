import 'package:cloud_firestore/cloud_firestore.dart';

class DBProfile {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static const customersPath = "customers";

  Future<dynamic> createFirestoreUser(
      String uid, String email, String username, String phone) async {
    var costumer = {
      "uid": uid,
      "name": username,
      "image": "",
      "email": email,
      "phone": phone,
    };

    await firestore.collection(customersPath).doc(uid).set(costumer);
  }
}
