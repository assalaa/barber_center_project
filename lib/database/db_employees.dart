import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/models/salon_employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseEmployee {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'employee';

  Future<void> addEmployee(String userId, EmployeeModel employeeModel) async {
    await _firestore
        .collection(_path)
        .doc(employeeModel.id)
        .set(employeeModel.toJson());
  }

  Future<void> deleteEmployee(String employeeId) async {
    await _firestore.collection(_path).doc(employeeId).delete();
  }

  Future<List<SalonEmployeeModel>> getAllEmployees() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection(_path).get();
    final List<SalonEmployeeModel> list = [];
    for (final doc in snapshot.docs) {
      final EmployeeModel employeeModel = EmployeeModel.fromJson(doc.data());

      if (list.any((element) => element.employees.contains(employeeModel))) {
        final int index = list.indexOf(list.firstWhere(
            (element) => element.salonId == employeeModel.employerUid));

        list[index].employees.add(employeeModel);
      } else {
        list.add(SalonEmployeeModel(
            salonId: employeeModel.employerUid, employees: [employeeModel]));
      }
    }
    return list;
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
