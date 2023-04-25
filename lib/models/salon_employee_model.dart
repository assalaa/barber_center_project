import 'package:barber_center/models/employee_model.dart';

class SalonEmployeeModel {
  final String salonId;
  List<EmployeeModel> employees;

  SalonEmployeeModel({required this.salonId, required this.employees});

  factory SalonEmployeeModel.fromJson(Map json) {
    return SalonEmployeeModel(
      salonId: json['employerUid'],
      employees: List<EmployeeModel>.from(
          json['employees'].map((x) => EmployeeModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'employerUid': salonId,
        'employees': List<dynamic>.from(employees.map((x) => x.toJson())),
      };
}
