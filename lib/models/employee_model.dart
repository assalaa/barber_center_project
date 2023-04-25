class EmployeeModel {
  String id;
  String name;
  String image;
  String employerUid;
  DateTime createAt;
  List<String> servicesIds;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.employerUid,
    required this.createAt,
    required this.servicesIds,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      employerUid: json['employerUid'],
      createAt: DateTime.parse(json['createAt']),
      servicesIds: List<String>.from(json['services'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'employerUid': employerUid,
        'createAt': createAt.toString(),
        'services': servicesIds,
      };
}
