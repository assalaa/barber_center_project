class BarberModel {
  final String barberId;
  String barberName;
  String? image;
  String salonId;
  String phone;
  bool homeService;
  List<String> services;

  BarberModel({
    required this.barberId,
    required this.barberName,
    required this.image,
    required this.salonId,
    required this.phone,
    required this.homeService,
    required this.services,
  });

  factory BarberModel.fromJson(Map json) {
    return BarberModel(
      barberId: json['barberId'],
      barberName: json['barberName'],
      salonId: json['salonId'],
      image: json['image'],
      phone: json['phone'],
      homeService: json['homeService'],
      services: List<String>.from(json['services']),
    );
  }

  Map<String, dynamic> toJson() => {
        'barberId': barberId,
        'barberName': barberName,
        'salonId': salonId,
        'image': image,
        'phone': phone,
        'homeService': homeService,
        'services': services
      };
}
