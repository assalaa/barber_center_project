import 'package:barber_center/models/barber_model.dart';

class SalonEmployeeModel {
  final String salonId;
  List<BarberModel> employees;

  SalonEmployeeModel({required this.salonId, required this.employees});

  factory SalonEmployeeModel.fromJson(Map json) {
    return SalonEmployeeModel(
      salonId: json['salonId'],
      employees: List<BarberModel>.from(
          json['employees'].map((x) => BarberModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'salonId': salonId,
        'employees': List<BarberModel>.from(employees.map((x) => x.toJson())),
      };
}
