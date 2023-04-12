class CostumerModel {
  late String uid;
  late String name;
  late String image;
  late String emailAddress;
  late String phoneNumber;

  CostumerModel({
    required uid,
    required name,
    required image,
    required emailAddress,
    required phoneNumber,
  });

  factory CostumerModel.fromJson(Map<String, dynamic> json) {
    return CostumerModel(
      uid: json['uid'],
      name: json['name'],
      image: json['image'],
      emailAddress: json['emailAddress'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['image'] = image;
    data['emailAddress'] = emailAddress;
    data['phoneNumber'] = phoneNumber;

    return data;
  }
}
