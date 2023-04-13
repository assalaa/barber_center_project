class UserModel {
  final String uid;
  final String kindOfUser;
  final DateTime createAt;
  String name;
  String? image;
  String email;
  String city;

  UserModel({
    required this.uid,
    required this.createAt,
    required this.kindOfUser,
    required this.name,
    required this.email,
    required this.city,
    this.image,
  });

  factory UserModel.fromJson(Map map) {
    return UserModel(
      uid: map['uid'],
      createAt: DateTime.parse(map['createAt']),
      kindOfUser: map['kindOfUser'] ?? 'CUSTOMER',
      name: map['name'],
      image: map['image'],
      email: map['email'],
      city: map['city'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['kindOfUser'] = kindOfUser;
    data['createAt'] = createAt.toString();
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['city'] = city;
    return data;
  }
}
