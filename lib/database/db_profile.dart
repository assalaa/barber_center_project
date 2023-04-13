import 'package:barber_center/models/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBProfile {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static const customersPath = 'customers';

  Future<dynamic> createFirestoreUser(CustomerModel customerModel) async {
    await firestore
        .collection(customersPath)
        .doc(customerModel.uid)
        .set(customerModel.toFirestore());
  }

  Future<CustomerModel> fetchCustomerProfile(String uid) async {
    return await firestore.collection(customersPath).doc(uid).get().then(
      (snapshot) {
        return CustomerModel.fromFirestore(snapshot);
      },
    );
  }
}
