import 'package:barber_center/main.dart';

class UserModel {
  final String uid;
  final KindOfUser kindOfUser;
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
      kindOfUser: getKindOfUser(map['kindOfUser']),
      name: map['name'],
      image: map['image'],
      email: map['email'],
      city: map['city'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['kindOfUser'] = setKindOfUser();
    data['createAt'] = createAt.toString();
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['city'] = city;
    return data;
  }

  static KindOfUser getKindOfUser(String kindOfUser) {
    if (kindOfUser == 'CUSTOMER') {
      return KindOfUser.CUSTOMER;
    } else if (kindOfUser == 'BARBER') {
      return KindOfUser.BARBER;
    } else if (kindOfUser == 'SALON') {
      return KindOfUser.SALON;
    } else if (kindOfUser == 'ADMIN') {
      return KindOfUser.ADMIN;
    } else {
      return KindOfUser.CUSTOMER;
    }
  }

  String setKindOfUser() {
    if (kindOfUser == KindOfUser.CUSTOMER) {
      return 'CUSTOMER';
    } else if (kindOfUser == KindOfUser.BARBER) {
      return 'BARBER';
    } else if (kindOfUser == KindOfUser.SALON) {
      return 'SALON';
    } else if (kindOfUser == KindOfUser.ADMIN) {
      return 'ADMIN';
    } else {
      return 'CUSTOMER';
    }
  }

  String print() {
    return 'uid: $uid, kindOfUser: ${setKindOfUser()}, createAt: $createAt, name: $name, image: $image, email: $email, city: $city';
  }
}
