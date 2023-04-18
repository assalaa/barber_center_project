import 'package:barber_center/models/saloon_service_details_model.dart';

class BookingModel {
  final String id;
  final String userId;
  final String salonId;
  final DateTime createAt;
  final DateTime date;
  final int durationInMin;
  final double price;
  final List<ServiceDetailModel> services;

  BookingModel({
    required this.id,
    required this.userId,
    required this.salonId,
    required this.createAt,
    required this.date,
    required this.durationInMin,
    required this.price,
    required this.services,
  });

  factory BookingModel.fromJson(Map json) {
    return BookingModel(
      id: json['id'],
      userId: json['userId'],
      salonId: json['salonId'],
      createAt: DateTime.parse(json['createAt']),
      date: DateTime.parse(json['date']),
      durationInMin: json['durationInMin'],
      price: json['price'],
      services: List<ServiceDetailModel>.from(json['services'].map((x) => ServiceDetailModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'salonId': salonId,
        'createAt': createAt.toIso8601String(),
        'date': date.toIso8601String(),
        'durationInMin': durationInMin,
        'price': price,
        'services': List<dynamic>.from(services.map((x) => x.toJson())),
      };
}
