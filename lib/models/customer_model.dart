class UserModel {
  final String uid;
  final String kindOfUser;
  String name;
  String? image;
  String email;
  String phone;

  UserModel({
    required this.uid,
    required this.kindOfUser,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });

  factory UserModel.fromJson(Map map) {
    return UserModel(
      uid: map['uid'],
      kindOfUser: map['kindOfUser'] ?? 'CUSTOMER',
      name: map['name'],
      image: map['image'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['kindOfUser'] = kindOfUser;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
