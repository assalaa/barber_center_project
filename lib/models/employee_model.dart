class EmployeeModel {
  String id;
  String name;
  String image;
  String employerUid;
  DateTime createAt;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.employerUid,
    required this.createAt,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      employerUid: json['employerUid'],
      createAt: DateTime.parse(json['createAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'employerUid': employerUid,
        'createAt': createAt.toString(),
      };
}
