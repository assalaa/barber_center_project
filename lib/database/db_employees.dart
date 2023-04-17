import 'package:barber_center/models/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseEmployee {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'employee';
  final String _usersPath = 'users';

  Future<void> addEmployee(String userId, EmployeeModel employeeModel) async {
    await _firestore
        .collection(_path)
        .doc(employeeModel.id)
        .set(employeeModel.toJson());

    await _linkEmployee(userId, employeeModel);
  }

  Future<void> _linkEmployee(String userId, EmployeeModel employeeModel) async {
    await _firestore.collection(_usersPath).doc(userId).update({
      'employees': FieldValue.arrayUnion([employeeModel.id])
    });
  }

  Future<List<EmployeeModel>> getEmployees(String userId) async {
    final List<EmployeeModel> employees = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_path)
          .where('employerUid', isEqualTo: userId)
          .get();
      for (final doc in querySnapshot.docs) {
        employees.add(EmployeeModel.fromJson(doc.data()));
      }
    } catch (e) {
      debugPrint('ERROR: $e');
    }

    return employees;
  }

  // Future<void> updateService(ServiceModel serviceModel) async {
  //   await _firestore.collection(_path).doc(serviceModel.id).update(serviceModel.toJson());
  // }

  // Future<ServiceModel?> getServiceById(String id) async {
  //   final DocumentSnapshot snapshot = await _firestore.collection(_path).doc(id).get();
  //   final Map map = snapshot.data() as Map;
  //   final ServiceModel user = ServiceModel.fromJson(map);
  //   return user;
  // }
}