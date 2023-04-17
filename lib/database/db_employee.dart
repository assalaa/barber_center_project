import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/employee_model.dart';

class DatabaseEmployee {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'employee';

  Future<void> addService(EmployeeModel employeeModel) async {
    await _firestore.collection(_path).doc(employeeModel.id).set(employeeModel.toJson());
  }
}
